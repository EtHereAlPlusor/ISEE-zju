static long32 f(ulong32 r, unsigned char subkey[8]){
    unsigned char s[4], plaintext[8], m[4], t[4];
    unsigned long int rval;
    int i, j;
    int n, byte, bit;
    int x, y;
    // (1) ����r��s��
    memset(s, 0, sizeof(s));
    for (i=3;i>=0;i--){
    	s[i] = (r >> 8*(3-i)) & 255;
	}
    // (2) ��չ��48λ
    memset(plaintext, 0, sizeof(plaintext));
    for (i=0;i<8;i++){
        for (j=0;j<6;j++){
            n = plaintext_32bit_expanded_to_48bit_table[6*i+j]-1;
            byte = n / 8; // �ڼ����ֽ�
            bit = n % 8; // �ڼ�λ
            if (s[byte] & bytebit[bit]){
                plaintext[i] |= bytebit[(j+2)%8]; // �����λ��Ϊ0
            }
        }
    }
    // (3) 8�����
    for (i=0;i<8;i++){
        plaintext[i] ^= subkey[i];
    }
    // (4) ��ѯsbox
    memset(m, 0, sizeof(m));
    for (i=0;i<8;i++){
        x = 0; // ��
        y = 0; // ��
        if (plaintext[i] & bytebit[2]){
            x += 2;
        }
        if (plaintext[i] & bytebit[7]){
            x += 1;
        }
        y = (plaintext[i] & 0x1E) >> 1;
        m[i/2] |= sbox[i][16*x+y] << (i % 2 == 0 ? 4 : 0); // �ϲ�
    }
    // (5) ����m�е�32λ��
    memset(t, 0, sizeof(t));
    for (i=0;i<32;i++){
        n = sbox_perm_table[i] - 1;
        byte = n / 8;
        bit = n % 8;
        if (m[byte] & bytebit[bit]){
            t[i/8] |= bytebit[i%8];
        }
    }
    // (6) ���Ʋ�����rval
    rval = 0;
    for (i=0;i<4;i++){
    	rval |= t[i] << 8*(3-i);
	}
    return rval;
}
