module top_module (
	input sel,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out
);

always @(sel, a, b) begin
	if (sel == 1'b0) begin
		out = b;
	end
	else if (sel == 1'b1) begin
		out = a;
	end
	else begin
		out = 8'b0;
	end
end

endmodule
