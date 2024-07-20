module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg D;

// Multiplexer for selecting the input

wire M;
assign M = E ? R : w;

always @(posedge clk) begin
	if (L) begin
		D <= M;
	end else if (E) begin
		D <= Q;
	end
end

// Flip-flop for storing the value

always @(posedge clk) begin
	Q <= D;
end

endmodule
