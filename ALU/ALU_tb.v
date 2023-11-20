`timescale 1ns/1ps
module ALU_tb;
reg [15:0] a,b;
reg [2:0] op;
wire cout;
wire [15:0] y;

ALU alu(.cout(cout),.y(y),.op(op),.a(a),.b(b));

initial begin
	/*arithmetic operation*/
	a  = 16'h8F54;
	b  = 16'h79F8;
	op = 3'b000;
	
	#10 op = 3'b001;
	
	#10 op = 3'b010;
	
	#10 op = 3'b011;
	
	/*logic operation*/
	#10
	a  = 16'b1001_0011_1101_0010;
	b  = 16'b1110_1101_1001_0111;
	op = 3'b100;
	
	#10 op = 3'b101;
	
	#10 op = 3'b110;
	
	#10 op = 3'b111;
	
	#10 $finish;
end

endmodule
