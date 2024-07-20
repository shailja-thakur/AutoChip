module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

reg out_sop; // define output reg for SOP form
reg out_pos; // define output reg for POS form
	
always @(a, b, c, d) begin
	if ((a == 0 && b == 0 && c == 1 && d == 0) || // 2
		(a == 0 && b == 1 && c == 1 && d == 1) || // 7
		(a == 1 && b == 1 && c == 1 && d == 1))   // 15
	begin
		out_sop = 1;
	else 
		out_sop = 0;
	end
	
	if ((a == 0 && b == 0 && c == 0 && d == 0) || // 0
		(a == 0 && b == 0 && c == 0 && d == 1) || // 1
		(a == 0 && b == 1 && c == 0 && d == 0) || // 4
		(a == 0 && b == 1 && c == 0 && d == 1) || // 5
		(a == 0 && b == 1 && c == 1 && d == 0) || // 6
		(a == 1 && b == 0 && c == 0 && d == 1) || // 9
		(a == 1 && b == 0 && c == 1 && d == 0) || // 10
		(a == 1 && b == 1 && c == 0 && d == 1) || // 13
		(a == 1 && b == 1 && c == 1 && d == 0))   // 14
	begin
		out_pos = 0;
	else 
		out_pos = 1;
	end
end

endmodule
