module top_module (
	input sel,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out
);

always @(sel or a or b) begin
	if (sel)
		out <= b; // Change assign to <= to make it a procedural assignment
	else
		out <= a; // Change assign to <= to make it a procedural assignment
end

endmodule
