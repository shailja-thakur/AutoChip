module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

reg [7:0] q;

always @(posedge clk) begin
	if (enable)
		q <= q << 1;
	else
		q <= q;
	
	if (S)
		q[0] <= A & B & C;
	
	Z <= q[{A, B, C}];
end

endmodule
