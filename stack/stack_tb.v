`timescale 1ns/1ps
module stack_tb;
reg clk;
reg [7:0]data_in; 
reg [1:0]cmd;
wire [7:0]data_out; 
wire full, empty, error;
//wire [2:0] sp;
stack stack(.clk(clk), .data_in(data_in), .cmd(cmd),.data_out(data_out), .full(full), .empty(empty), .error(error)/*, .sp(sp)*/);

parameter NOP = 2'b00, 
		  CLR = 2'b01, 
		  PUSH = 2'b10, 
		  POP = 2'b11;

initial clk = 1'b0;

always #5 clk = ~clk;

initial 
begin
	cmd <= #0   CLR;  data_in <= #0   8'hxx; 
	cmd <= #10  POP;  data_in <= #10  8'hxx; 
	cmd <= #20  POP;  data_in <= #20  8'hxx; 
	cmd <= #30  PUSH; data_in <= #30  8'h01; 
	cmd <= #40  PUSH; data_in <= #40  8'h02; 
	cmd <= #50  NOP;  data_in <= #50  8'hxx; 
	cmd <= #60  POP;  data_in <= #60  8'hxx; 
	cmd <= #70  PUSH; data_in <= #70  8'h03; 
	cmd <= #80  PUSH; data_in <= #80  8'h04; 
	cmd <= #90  PUSH; data_in <= #90  8'h05; 
	cmd <= #100 PUSH; data_in <= #100 8'h06; 
	cmd <= #110 PUSH; data_in <= #110 8'h07; 
	cmd <= #120 PUSH; data_in <= #120 8'h08; 
	cmd <= #130 PUSH; data_in <= #130 8'h09;
	cmd <= #140 PUSH; data_in <= #140 8'h0A; 
	cmd <= #150 PUSH; data_in <= #150 8'h0B; 
	cmd <= #160 PUSH; data_in <= #160 8'h0C; 
	cmd <= #170 POP;  data_in <= #170 8'hxx; 
	cmd <= #180 POP;  data_in <= #180 8'hxx; 
	cmd <= #190 POP;  data_in <= #190 8'hxx; 
	cmd <= #200 NOP;  data_in <= #200 8'hxx; 
	cmd <= #210 CLR;  data_in <= #210 8'hxx; 
	cmd <= #220 PUSH; data_in <= #220 8'h10; 
	cmd <= #230 PUSH; data_in <= #230 8'h20; 
	cmd <= #240 POP;  data_in <= #240 8'hxx;

	#270 $finish; 
end 
endmodule
