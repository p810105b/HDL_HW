module ALU(a, b, op, y, cout);
input  [15:0] a;
input  [15:0] b;
input  [2:0]  op;
output [15:0] y;
output cout;

wire [16:0] plus;
wire [16:0] minus;
wire [15:0] min;
wire [15:0] max;

wire [15:0] AND;
wire [15:0] OR;
wire [15:0] XOR;
wire [15:0] XNOR;

assign plus  = a + b;
assign minus = a - b;
assign min   = (a < b) ? a : b;
assign max   = (a > b) ? a : b;
assign AND   = a & b;
assign OR    = a | b;
assign XOR   = a ^ b;
assign XNOR  = ~(a ^ b);


assign {cout, y} = (op == 3'b000) ? plus 	   :
				   (op == 3'b001) ? {0, minus} :
				   (op == 3'b010) ? {0, min}   :
				   (op == 3'b011) ? {0, max}   :
				   (op == 3'b100) ? {0, AND}   :
				   (op == 3'b101) ? {0, OR}    :
				   (op == 3'b110) ? {0, XOR}   : {0, XNOR};


endmodule