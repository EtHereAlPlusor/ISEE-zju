module counter_n(clk, en, r, q, co);
	parameter n = 2; // ������ģ(��Ƶ��)
	parameter counter_bits = 1; // ״̬λ�� 
	input clk, en, r ;
	output co; // ��λ���
	output reg[counter_bits-1:0] q = 0;
  
	assign co = (q == (n-1)) && en; //��λ
	
	always @(posedge clk) 
	begin
      if (r) q = 0;
	  else if(en)  // ʹ�ܸߵ�ƽ����
	  begin	 
		if (q == (n-1)) q = 0 ; // ��0��ʵ��ѭ������
		else q = q + 1; // ����
	  end
	  else q = q; // ���򱣳�
	end
endmodule
