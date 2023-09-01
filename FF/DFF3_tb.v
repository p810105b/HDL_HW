module D_FF3_tb;
reg clk,enable,d;
wire q;
D_FF3 unit3(.q(q), .din(d), .clk(clk), .enable(enable)); // design instantiation
initial // stimulus block for (a) waveforms
clk = 1'b1;
always #10 clk = ~clk; // flip the clk value every 10 time units
initial begin
 enable = 1'b1;
 d = 1'b0;
 #7 d = 1'b1;
 #18 d = 1'b0;
 #10 d = 1'b1; 
 #0 enable = 1'b0;
 #3 d = 1'b0;
 #7 d = 1'b1;
 #8 d = 1'b0;
 #13 $finish;
end 
endmodule