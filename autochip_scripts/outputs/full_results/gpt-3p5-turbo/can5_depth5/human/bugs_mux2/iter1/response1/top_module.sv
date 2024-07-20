module top_module (
	input sel,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out
);

always @(*)
begin
	if (sel == 0)
		out <= a; // Use non-blocking assignment
	else
		out <= b; // Use non-blocking assignment
end

endmodule
