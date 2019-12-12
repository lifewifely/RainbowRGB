module RGB(input CLK,input[1:0]FLAG,output LED);

wire UP;
wire DW;
wire STT0;
wire STT1;
PWM up(CLK,1'b1,STT0,UP);
PWM dw(CLK,1'b0,STT1,DW);

reg[1:0]flag;
reg E=1'b0;

always@(posedge STT0)
	if(!E)begin
		flag<=FLAG;
		E<=1'b1;
	end
	else if(flag==2'b10)
		flag<=1'b0;
	else
		flag<=flag+1'b1;

assign LED=(flag==2'b00)?UP:((flag==2'b01)?DW:1'b1);

endmodule