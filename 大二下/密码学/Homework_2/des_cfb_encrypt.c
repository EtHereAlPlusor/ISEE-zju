void des_cfb_encrypt(unsigned char p[], int n, unsigned char des_seed_iv[],unsigned char des_iv[], unsigned char des_seed_key[]){
    int i, j;
    unsigned char k[n];
    unsigned char c[n+1];
    unsigned char des_key[8], cp_des_iv[8];

    // ���des_key
    for (i=0;i<8;i++){
        k[i] = des_seed_iv[i] ^ des_iv[i];
        des_key[i] = des_seed_key[i] ^ k[i];
    }

    // �Գ�ʼ���������м���
    for (j=0;j<8;j++){
    	cp_des_iv[j]=des_iv[j];
	}
    des_encrypt(cp_des_iv, des_key);

    // ��CFBģʽ��������
    for (i=0; i<n; i++){
        c[i] = cp_des_iv[0] ^ p[i];
        for (j=0; j<7; j++){
            des_iv[j] = des_iv[j+1];
        }
        des_iv[7] = c[i];
        for (j=0;j<8;j++){
    	    cp_des_iv[j]=des_iv[j];
	    }
        des_encrypt(cp_des_iv, des_key);
    }
    i = 0;
    while (i<n){
       printf("%02X", c[i++]);
	}
}
