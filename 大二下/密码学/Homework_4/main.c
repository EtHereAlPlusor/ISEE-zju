#include <stdio.h>
#include <string.h>
#include <openssl/rsa.h>
#include <openssl/rand.h>
#include <openssl/bn.h>
#include <openssl/ec.h>
#include <openssl/sha.h>

#pragma comment(lib, "libeay32.lib")
#pragma comment(lib, "ssleay32.lib")

char A[0x100], B[0x100], PE[0x100];   // ecc���߲���a, b, p
char GX[0x100], GY[0x100], NE[0x100]; // ����G��x����, y����, G�Ľ�(��Ϊ256λ)
char DE[0x100];                       // ecc��˽Կd(256λ)
char N1[2][0x100], D1[2][0x100], X2[2][0x100]; 
                // N1�����ecc��Կ���ܹ���rsa����N, 
                // ����N1[0]��ŵ�1��������, N1[1]��ŵ�2��������;
                // D1�����ecc��Կ���ܹ���rsa˽Կd;
                // X2�����ecc��Կ���ܹ���X1
char X1[0x100]; // X1�����rsa��Կ���ܹ���X                      
char X[0x100];  // X���һ��256λ�������, X<N �� X<NE
char N[0x100], D[0x100];       // rsa��N��˽Կd(256λ)
char RX[0x100], RY[0x100];     // ecc��ԿR��x���꼰y���� 
char C[2][0x100]; // �����ecc��Կ���ܹ���X, C[0]�ǵ�1��������, C[1]�ǵ�2��������
char S[2][0x100]; // �����ecnrǩ������RSA_private_encrypt_PKCS1_type_2(SHA1(X), D)
                  // ����SHA1��ɢ���㷨, RSA_private_encrypt_PKCS1_type_2()����RSA��
                  // ˽Կd��SHA1(X)���м���(ʵ������ǩ��), ����ǰ�����SHA1(X)��PKCS1_type_2
                  // ��ʽ�������, ʹ��SHA1(X)�ĳ��ȴ�20�ֽڱ��0x20�ֽ�(��256λ);
                  // ���NΪ256λ��PKCS1_type_2����ʽ����:
                  // 0x00, 0x02, 9�ֽڷ��������, 0x00, 20�ֽ�����
                  // ����������, S�Ƕ�SHA1(X)������ǩ��, ��1������rsa��˽Կǩ��, ��2������ecc��˽Կǩ��

// 1�����X��N��D;
// 2����ecc�Ĺ�Կ��X���м���, ������浽C��;
// 3����rsa��˽Կ��SHA1(X)����ǩ��, ����ecc��ecnr�㷨��rsaǩ������һ��ǩ��,���������S��;
// 4�����C[0], C[1], S[0], S[1] 

int main()
{
	EC_GROUP *group;
   	BN_CTX *ctx;
   	EC_POINT *G, *T, *R; // G�ǻ���, T����ʱ��, R�ǹ�Կ��
    BIGNUM *p, *a, *b, *n, *gx, *gy, *tx, *ty;
   	BIGNUM *m, *d, *r, *s, *k; // m������, d��˽Կ, r�����ĵĵ�һ����, s�����ĵĵڶ�����
   	BIGNUM *rsan, *rsad, *rsae; // RSA���ܲ���
	RSA *prsa = RSA_new(); // RSA��Կ
	char MX[0x100]; // SHA1(X)
    char X3[0x100]; // �����SHA1(X)
	char X4[0x100];
	long ticks;
   	int i, len;
    
    scanf("%s", A); // inputs
    scanf("%s", B);
    scanf("%s", PE);
    scanf("%s", GX);
    scanf("%s", GY);
    scanf("%s", NE);
    scanf("%s", DE);
    scanf("%s", N1[0]);
    scanf("%s", N1[1]);
    scanf("%s", D1[0]);
    scanf("%s", D1[1]);
    scanf("%s", X2[0]);
    scanf("%s", X2[1]);
    
    
    a = BN_new(); // �����ڴ� 
    b = BN_new();  
	p = BN_new(); 
	gx = BN_new();
    gy = BN_new();
    n = BN_new();  
	d = BN_new();
    tx = BN_new();
    ty = BN_new();
    r = BN_new();
    s = BN_new();
    m = BN_new(); // m������ܳ��������� 
    k = BN_new();
	rsan = BN_new();
	rsae = BN_new();
	rsad = BN_new();
    
    BN_hex2bn(&a, A);
    BN_hex2bn(&b, B); // ϵ�� 
    BN_hex2bn(&p, PE); // mod p 
    BN_hex2bn(&gx, GX);
    BN_hex2bn(&gy, GY); // ��������� 
	BN_hex2bn(&n, NE); // �� 
    BN_hex2bn(&d, DE); // ˽Կ 
    
    group = EC_GROUP_new(EC_GFp_mont_method());
    ctx = BN_CTX_new();
    EC_GROUP_set_curve_GFp(group, p, a, b, ctx); // Ⱥ 
    
    G = EC_POINT_new(group); 
   	EC_POINT_set_affine_coordinates_GFp(group, G, gx, gy, ctx); // ���û������� 
   	EC_GROUP_set_generator(group, G, n, BN_value_one()); // ����=G, G�Ľ�=n, ������=1
    
    T = EC_POINT_new(group); // ��ʱ�� 
    
	// �Ƚ� N
    BN_hex2bn(&r, N1[0]); 
	BN_hex2bn(&s, N1[1]); 
    
    EC_POINT_set_compressed_coordinates_GFp(group, T, r, 0, ctx); // �ɺ�������������� T=r
	EC_POINT_mul(group, T, NULL, T, d, ctx); // T = d*r
   	EC_POINT_get_affine_coordinates_GFp(group, T, tx, ty, ctx); // tx = (d*r).x 
   	BN_mod_inverse(tx, tx, n, ctx); // tx = tx^-1 = (d*r).x ^ -1
   	BN_clear(rsan);
   	BN_mod_mul(rsan, s, tx, n, ctx); // rsan = s/(d*r).x
   	memset(N, 0, sizeof(N)); 
   	BN_bn2bin(rsan, N); // ����õ� N ���������
    
	// �� rsa ��˽Կ d
    BN_hex2bn(&r, D1[0]);  
	BN_hex2bn(&s, D1[1]); 
    
    EC_POINT_set_compressed_coordinates_GFp(group, T, r, 0, ctx); // �ɺ�������������� T=r
	EC_POINT_mul(group, T, NULL, T, d, ctx); // T = d*r
   	EC_POINT_get_affine_coordinates_GFp(group, T, tx, ty, ctx); // tx = (d*r).x 
   	BN_mod_inverse(tx, tx, n, ctx); // tx = tx^-1 = (d*r).x ^ -1
   	BN_clear(rsad);
   	BN_mod_mul(rsad, s, tx, n, ctx); // rsad = s/(d*r).x
   	memset(D, 0, sizeof(D)); 
   	BN_bn2bin(rsad, D); // ����õ� D ���������
   	
	// �� X1 
   	BN_hex2bn(&r, X2[0]); 
	BN_hex2bn(&s, X2[1]); 

	EC_POINT_set_compressed_coordinates_GFp(group, T, r, 0, ctx); // �ɺ�������������� T=r
	EC_POINT_mul(group, T, NULL, T, d, ctx); // T = d*r
   	EC_POINT_get_affine_coordinates_GFp(group, T, tx, ty, ctx); // tx = (d*r).x 
   	BN_mod_inverse(tx, tx, n, ctx); // tx = tx^-1 = (d*r).x ^ -1
   	BN_clear(m);
   	BN_mod_mul(m, s, tx, n, ctx); // m = s/(d*r).x
   	
   	memset(X1, 0, sizeof(X1)); 
   	BN_bn2bin(m, X1); // ����õ� X1 ���������
   	
	// ���� RSA ��Կ
	prsa = RSA_new();
	prsa->flags |= RSA_FLAG_NO_BLINDING; // �ر�blindingģʽ
	prsa->n = rsan;
	prsa->d = rsad;
	prsa->e = NULL;
	RSA_private_decrypt(32, X1, X, prsa, RSA_NO_PADDING); // RSA ������ X, ��ʱ X ÿ���ֽڵ�ASCII��Ϊ����

    // ��ecc�Ĺ�Կ���� X
	R = EC_POINT_new(group); // ��Կ�� 
    EC_POINT_mul(group, R, d, NULL, NULL, ctx); // ��Կ R = d*G
    EC_POINT_get_affine_coordinates_GFp(group, R, tx, ty, ctx); // tx, ty ������ R ������ 
    strcpy(RX, BN_bn2hex(tx));
    strcpy(RY, BN_bn2hex(ty)); // ���� R �ĺ������� 
    
    // ��������� 
	ticks = (long)time(NULL);
	RAND_add(&ticks, sizeof(ticks), 1);
	BN_rand(k, BN_num_bits(n), 0, 0); // ���������k
    
    // ����
	EC_POINT_mul(group, T, k, NULL, NULL, ctx); // T = k*G 
	EC_POINT_get_affine_coordinates_GFp(group, T, tx, ty, ctx); // tx = (k*G).x 
    BN_copy(r, tx); // ���ĵ�һ����
	EC_POINT_mul(group, T, NULL, R, k, ctx); // T = k*R
    EC_POINT_get_affine_coordinates_GFp(group, T, tx, ty, ctx); // tx = (k*R).x
    BN_bin2bn(X, BN_num_bytes(n), m); // m = X
    BN_mod_mul(s, m, tx, n, ctx); // s = ���ĵڶ����� 
    strcpy(C[0], BN_bn2hex(r));
    strcpy(C[1], BN_bn2hex(s)); // ������ܺ�� X 
	
	puts(C[0]);
    puts(C[1]);
    
	memset(MX, 0, sizeof(MX));
    SHA1(X, 32, MX); // MX = SHA1(X)

	// ���
	memset(X3, 0, sizeof(X3));
	X3[0] = 0x00;
	X3[1] = 0x02;
	for (i=2; i<11; i++){
		ticks = (long)time(NULL);
		srand((unsigned int)ticks); 
		X3[i] = (char)rand();
	} // 9�ֽ������
	X3[11] = 0x00;
	for (i=12; i<32; i++){
		X3[i] = MX[i-12];
	}

	len = RSA_size(prsa);
	memset(X4, 0, sizeof(X4));
    RSA_private_encrypt(len, X3, X4, prsa, RSA_NO_PADDING); // ��RSA��˽Կ��SHA1(X)����һ�μ��� 
    
    // ��������� 
	ticks = (long)time(NULL);
	RAND_add(&ticks, sizeof(ticks), 1);
	BN_rand(k, BN_num_bits(n), 0, 0); // ���������k
    
    // ecnr ǩ�� 
    EC_POINT_mul(group, T, k, NULL, NULL, ctx); // T = k*G 
	EC_POINT_get_affine_coordinates_GFp(group, T, tx, ty, ctx); // tx = (k*G).x 
	BN_mod(tx, tx, n, ctx);  // tx = (k*G).x mod n
    BN_bin2bn(X4, BN_num_bytes(n), m); // m = RSA���ܺ��SHA1(X) 
    BN_add(r, tx, m); // r = (k*G).x + m 
    BN_mod(r, r, n, ctx);  // ǩ����һ����
	memset(S[0], 0, sizeof(S[0])); 
   	strcpy(S[0], BN_bn2hex(r)); // ����õ�ǩ�����������
   	
   	BN_mod_mul(s, r, d, n, ctx); // s = r*d mod n
    BN_set_negative(s, 1); // s = -(r*d)
    BN_add(s, n, s); // s = n-(r*d)
    BN_mod_add(s, k, s, n, ctx); // ǩ���ڶ�����
	memset(S[1], 0, sizeof(S[1])); 
   	strcpy(S[1], BN_bn2hex(s)); // ����õ�ǩ�����������
   	
    puts(S[0]);
    puts(S[1]);
    
    return 0;
}