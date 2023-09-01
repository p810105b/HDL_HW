`timescale 1ns/1ps
module ram4096X16_tb; 

reg  clk, rw; 
reg  [11:0] addr; 
reg  [15:0] data;
wire [15:0] dout; 

integer k; 

assign dout = (!rw) ? 16'hzzzz : data; 

ram4096X16 r0(.clk(clk), .rw(rw), .addr(addr),.data(dout));

always #5 clk=~clk ;

always@(dout) begin
	if(!rw)
		data = dout;
end

initial begin
	clk = 1'b0;
end
		
initial begin 
	//write//
	rw <= 1'b1; 
	for(k = 0; k < 8; k = k+1) begin 
		addr <= 12'h000 +k; 
		data <= 16'h0000+k;
		#10; 
		addr <= 12'h400 +k; 
		data <= 16'h0400+k; 
		#10; 
		addr <= 12'h800 +k; 
		data <= 16'h0800+k; 
		#10; 
		addr <= 12'hc00 +k; 
		data <= 16'h0c00+k; 
		#10; 
	end 
		
	//read//	
	rw <= 1'b0;	
	for(k=1; k < 5; k = k+1) begin 
		addr <= 12'hc00+k; 
		#10; 
		addr <= 12'h800+k; 
		#10; 
		addr <= 12'h400+k; 
		#10; 
		addr <= 12'h000+k; 
		#10; 
	end 
	
	//write//
	rw <= 1'b1;	
	for(k=0; k < 8; k = k+1) begin  
		addr <= 12'h000 + k; 
		data <= 16'b0000+ ( k<<8 ); 
		#10; 
		addr <= 12'h400 + k; 
		data <= 16'h0004+ ( k<<8 ) ; 
		#10; 
		addr <= 12'h800 + k; 
		data <= 16'h0008+ ( k<<8 ) ;
		#10; 
		addr <= 12'hc00 + k; 
		data <= 16'h000c+ ( k<<8 ) ;
		#10; 
	end 
	
	//read//
	rw <= 1'b0;
	for(k=3; k > -1 ; k = k-1) begin 
		addr<=12'h000+k; 
		#10; 
		addr<=12'h400+k; 
		#10;
		addr<=12'h800+k; 
		#10;
		addr<=12'hc00+k; 
		#10; 
	end 
#10 $finish;
end 

endmodule 