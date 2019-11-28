/*
实现彩虹效果呼吸灯,
用按键控制呼吸频率,
单灯或双灯同步等功能.
*/
module RainbowRGB
(input CLK
,output[2:0]LED
);

wire UP;
wire DW;
wire NO;
wire STT1;
wire STT2;//占位
wire STT3;//占位
PWM UUD1(CLK,1,1,STT1,UP);
PWM UUD2(CLK,0,1,STT2,DW);
PWM UUD3(CLK,1,0,STT3,NO);

reg[1:0]flag1=2'b00;
reg[1:0]flag2=2'b01;
reg[1:0]flag3=2'b10;
always@(posedge STT1)
	if(flag1==2'b10)
		flag1<=2'b00;
	else
		flag1<=flag1+1'b1;
always@(posedge STT1)
	if(flag2==2'b10)
		flag2<=2'b00;
	else
		flag2<=flag2+1'b1;
always@(posedge STT1)
	if(flag3==2'b10)
		flag3<=2'b00;
	else
		flag3<=flag3+1'b1;

assign LED[0]=(flag1==2'b00)?UP:((flag1==2'b01)?DW:NO);
assign LED[1]=(flag2==2'b00)?UP:((flag2==2'b01)?DW:NO);
assign LED[2]=(flag3==2'b00)?UP:((flag3==2'b01)?DW:NO);

endmodule