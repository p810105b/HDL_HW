module ram4096X16(clk, addr, data, rw); 
input clk, rw; 
input [11:0] addr; 
inout [15:0] data; /* external I/O node, bidirectional */

wire cs_0, cs_1, cs_2, cs_3;

assign cs_0 = (addr[11:10] == 2'b00) ? 1'b0 : 1'b1;
assign cs_1 = (addr[11:10] == 2'b01) ? 1'b0 : 1'b1;
assign cs_2 = (addr[11:10] == 2'b10) ? 1'b0 : 1'b1;
assign cs_3 = (addr[11:10] == 2'b11) ? 1'b0 : 1'b1;


ram1024X8 u0_0(.clk(clk), .addr(addr[9:0]), .data(data[7:0]),  .rw(rw), .cs(cs_0)); 
ram1024X8 u0_1(.clk(clk), .addr(addr[9:0]), .data(data[15:8]), .rw(rw), .cs(cs_0)); 

ram1024X8 u1_0(.clk(clk), .addr(addr[9:0]), .data(data[7:0]),  .rw(rw), .cs(cs_1)); 
ram1024X8 u1_1(.clk(clk), .addr(addr[9:0]), .data(data[15:8]), .rw(rw), .cs(cs_1)); 

ram1024X8 u2_0(.clk(clk), .addr(addr[9:0]), .data(data[7:0]),  .rw(rw), .cs(cs_2)); 
ram1024X8 u2_1(.clk(clk), .addr(addr[9:0]), .data(data[15:8]), .rw(rw), .cs(cs_2)); 

ram1024X8 u3_0(.clk(clk), .addr(addr[9:0]), .data(data[7:0]),  .rw(rw), .cs(cs_3)); 
ram1024X8 u3_1(.clk(clk), .addr(addr[9:0]), .data(data[15:8]), .rw(rw), .cs(cs_3)); 
 
endmodule 


module ram1024X8(clk, addr, data, rw, cs); 
input clk, rw, cs; 
input [9:0] addr; 
inout [7:0] data; /* external I/O node, bidirectional */

reg [7:0] ram [0:1023];
wire [7:0] dout; /* internal node, uni-directional */

assign data = (!cs) && (!rw) ? dout : 8'bzzzz_zzzz;
assign dout = ram[addr];

integer i;
always@(posedge clk) begin
	if(~cs && rw) begin // rw = 1 : wirite, cs = 1 : out high z
		ram[addr] <= data;
	end	
end

endmodule 
