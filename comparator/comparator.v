`timescale 1ns/1ps
module comparator(a, b, a_gt_b, a_eq_b, a_lt_b);
input [15:0] a;
input [15:0] b; 
output a_gt_b; 
output a_eq_b; 
output a_lt_b; 

wire [3:0] gt, eq, lt;

comparator_4b u0(.data_a(a[15:12]), .data_b(b[15:12]), .gt(gt[3]), .eq(eq[3]), .lt(lt[3]));
comparator_4b u1(.data_a(a[11:8]),  .data_b(b[11:8]),  .gt(gt[2]), .eq(eq[2]), .lt(lt[2]));
comparator_4b u2(.data_a(a[7:4]),   .data_b(b[7:4]),   .gt(gt[1]), .eq(eq[1]), .lt(lt[1]));
comparator_4b u3(.data_a(a[3:0]),   .data_b(b[3:0]),   .gt(gt[0]), .eq(eq[0]), .lt(lt[0]));

comparator_4b u4(.data_a(gt[3:0]), .data_b(lt[3:0]), .gt(a_gt_b), .eq(a_eq_b), .lt(a_lt_b));

endmodule


/* 4-bit magnitude comparator module*/ 
module comparator_4b(data_a, data_b, gt, eq, lt); 
input [3:0] data_a;
input [3:0] data_b; 
output reg gt; /* gt = 1 if data_a > data_b */ 
output reg eq; /* eq = 1 if data_a == data_b */ 
output reg lt; /* gt = 1 if data_a < data_b */ 

always@(*) begin
	if(data_a > data_b) begin
		gt <= #3 1'b1;
		lt <= #4 1'b0;
		eq <= #5 1'b0;
	end
	else if(data_a == data_b) begin
		gt <= #3 1'b0;
		lt <= #4 1'b0;
		eq <= #5 1'b1;
	end
	else begin
		gt <= #3 1'b0;
		lt <= #4 1'b1;
		eq <= #5 1'b0;
	end
end

endmodule