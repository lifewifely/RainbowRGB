module RainbowRGB
(input CLK
,output LED
);

wire UP;
wire DW;
wire STT0;
wire STT1;
PWM up(CLK,1,STT0,UP);
PWM dw(CLK,0,STT1,DW);

reg[1:0]flag;
always@(posedge STT0)
	if(flag==2'b10)
		flag<=1'b0;
	else
		flag<=flag+1'b1;

assign LED=(flag==2'b00)?UP:((flag==2'b01)?DW:1'b1);

endmodule