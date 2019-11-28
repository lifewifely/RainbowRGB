module RainbowRGB
(input CLK
,output[2:0]LED
);

wire UP;
wire DW;
wire STT0;
wire STT1;
PWM up(CLK,1,STT0,UP);
PWM dw(CLK,0,STT1,DW);

reg[1:0]flag0=2'b00;
always@(posedge STT0)
	if(flag0==2'b10)
		flag0<=1'b0;
	else
		flag0<=flag0+1'b1;
assign LED[0]=(flag0==2'b00)?UP:((flag0==2'b01)?DW:1'b1);

reg[1:0]flag1=2'b01;
always@(posedge STT0)
	if(flag1==2'b10)
		flag1<=1'b0;
	else
		flag1<=flag1+1'b1;
assign LED[1]=(flag1==2'b00)?UP:((flag1==2'b01)?DW:1'b1);

reg[1:0]flag2=2'b10;
always@(posedge STT0)
	if(flag2==2'b10)
		flag2<=1'b0;
	else
		flag2<=flag2+1'b1;
assign LED[2]=(flag2==2'b00)?UP:((flag2==2'b01)?DW:1'b1);

endmodule