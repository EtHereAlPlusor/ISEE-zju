#include<stdio.h>
#include<string.h>
int main()
{
	char reflector[]="YRUHQSLDPXNGOKMIEBFZCWVJAT"; 
  	char rotor_table[5][27] = 
	{
	    "EKMFLGDQVZNTOWYHXUSPAIBRCJ", // 1 
	    "AJDKSIRUXBLHWTMCQGZNPYFVOE", // 2 
	    "BDFHJLCPRTXVZNYEIWGAKMUSQO", // 3
	    "ESOVPZJAYQUIRHXLNFTGKDCMWB", // 4
	    "VZBRGITYUPSDNHLXAWMJQOFECK" // 5
	};
	char step_char[6]="RFWKA"; // Royal Flags Wave Kings Above
	
	char plug[30];
	char ringSetting[4];
	char cypher0[501];
	char word[21];
	int leftNumber;
	
	char orMessageKey[4]="AAA";
	char messageKey[4];
	char plainText[600];
	int rotorNum[3];
	char cypher[600]="\0";
	
	int i=0, j=0, k=0;
	int delta[3];
	int position;
	int rightNumber, midNumber;
	int wordlen, textlen;
	int flag=0;
	int findKey=0;
	
	gets(plug);
	gets(ringSetting);
	gets(cypher0);
	gets(word);
	scanf("%d",&leftNumber);
	leftNumber--; // rotor�±��0��ʼ
	
	for (midNumber=0;midNumber<5&&flag==0;midNumber++){
		if (midNumber==leftNumber){
			continue;
		}
		for (rightNumber=0;rightNumber<5&&flag==0;rightNumber++){
			if (rightNumber==leftNumber || rightNumber==midNumber){
				continue; // �������������ظ�
			}
			while (findKey<26*26*26 && flag==0){
				strcpy(cypher,cypher0);
				i=0;
				while (cypher[i]){
					for (j=0;j<29;j++){
						if (cypher[i]==plug[j]){
							if (j%3==0){
								cypher[i]=plug[j+1];
							}
							else {
								cypher[i]=plug[j-1];
							}
							break;
						}
					}
					i++;
				} // plugboard
				i=0;
				strcpy(messageKey,orMessageKey);
				while (cypher[i]){ // ������������ 
				// �������ĺ󣬳���ת������λ��
					if (midNumber==0&&messageKey[1]=='Q' ||
						midNumber==1&&messageKey[1]=='E' ||
						midNumber==2&&messageKey[1]=='V' ||
						midNumber==3&&messageKey[1]=='J' ||
						midNumber==4&&messageKey[1]=='Z'
						){
							messageKey[0]=(messageKey[0]-'A'+1)%26+'A'; // ���������ĳ�����ת
							messageKey[1]=(messageKey[1]-'A'+1)%26+'A'; // �м���Ҳ����ת
							messageKey[2]=(messageKey[2]-'A'+1)%26+'A';
					}
					else if (rightNumber==0&&messageKey[2]=='Q' || 
							 rightNumber==1&&messageKey[2]=='E' || 
					 		 rightNumber==2&&messageKey[2]=='V' || 
					 		 rightNumber==3&&messageKey[2]=='J' ||
							 rightNumber==4&&messageKey[2]=='Z'
						) {
							messageKey[2]=(messageKey[2]-'A'+1)%26+'A';
							messageKey[1]=(messageKey[1]-'A'+1)%26+'A'; // �����м�ĳ�����ת
					}
					else {
						messageKey[2]=(messageKey[2]-'A'+1)%26+'A';
					}
					position=cypher[i]-'A'; // ȷ���ǵڼ�����ĸ
					delta[2]=messageKey[2]-ringSetting[2]; // ���Ҳ���ֵ�delta
					delta[1]=messageKey[1]-ringSetting[1];
					delta[0]=messageKey[0]-ringSetting[0];
					cypher[i]=(cypher[i]-'A'+delta[2]+26)%26+'A';
					position=cypher[i]-'A';
					// �������Ҳ�ĳ���
					cypher[i]=(rotor_table[rightNumber][position]-'A'-delta[2]+26)%26+'A';
					cypher[i]=(cypher[i]-'A'+delta[1]+26)%26+'A';
					position=cypher[i]-'A';
					// �����м�ĳ���
					cypher[i]=(rotor_table[midNumber][position]-'A'-delta[1]+26)%26+'A';
					cypher[i]=(cypher[i]-'A'+delta[0]+26)%26+'A';
					position=cypher[i]-'A';
					// ���������ĳ���
					cypher[i]=(rotor_table[leftNumber][position]-delta[0]-'A'+26)%26+'A';
					position=cypher[i]-'A';
					// ���뷴���
					cypher[i]=(reflector[position]+delta[0]-'A'+26)%26+'A';
					// ���������ĳ���
					for (k=0;k<26;k++){
						if (rotor_table[leftNumber][k]==cypher[i]){
							cypher[i]='A'+k;
							break;
						}
					}
					cypher[i]=(cypher[i]-delta[0]-'A'+26)%26+'A';
					cypher[i]=(cypher[i]+delta[1]-'A'+26)%26+'A';
					// �����м�ĳ���
					for (k=0;k<26;k++){
						if (rotor_table[midNumber][k]==cypher[i]){
							cypher[i]='A'+k;
							break;
						}
					}
					cypher[i]=(cypher[i]-delta[1]-'A'+26)%26+'A';
					cypher[i]=(cypher[i]+delta[2]-'A'+26)%26+'A';
					// �������Ҳ�ĳ���
					for (k=0;k<26;k++){
						if (rotor_table[rightNumber][k]==cypher[i]){
							cypher[i]='A'+k;
							break;
						}
					}
					cypher[i]=(cypher[i]-delta[2]-'A'+26)%26+'A';
					plainText[i]=cypher[i]; // ����һ����ĸ
					i++;
				}
				plainText[i]='\0';
				i=0;
				while (plainText[i]){
					for (j=0;j<29;j++){
						if (plainText[i]==plug[j]){
							if (j%3==0){
								plainText[i]=plug[j+1];
							}
							else {
								plainText[i]=plug[j-1];
							}
							break;
						}
					}
					i++;
				} // plugboard
				// �����������Ƿ���word
				textlen=strlen(plainText);
				wordlen=strlen(word);
				for (j=0;j<=textlen-wordlen;j++){
					if (!strncmp(plainText+j,word,wordlen)){ // �����к���word
						flag=1;
						strcpy(messageKey,orMessageKey);
						rotorNum[0]=leftNumber+1;
						rotorNum[1]=midNumber+1;
						rotorNum[2]=rightNumber+1;
						printf("MessageKey=%s\n",messageKey);
						printf("PlainText=%s\n",plainText);
						printf("RotorNum=");
						for (k=0;k<3;k++){
							printf("%d",rotorNum[k]);
						}
						printf("\n");
						break;
					}
				}
				if (j>textlen-wordlen){ // �����в���word 
					orMessageKey[2]=(orMessageKey[2]-'A'+1)%26+'A';
					if (orMessageKey[2]=='A'){
						orMessageKey[1]=(orMessageKey[1]-'A'+1)%26+'A';
						if (orMessageKey[1]=='A'){
							orMessageKey[0]=(orMessageKey[0]-'A'+1)%26+'A';
						}
					}
				}
				findKey++;
			}
			if (flag==0){
				findKey=0;
			}
		}
	}
 } 

