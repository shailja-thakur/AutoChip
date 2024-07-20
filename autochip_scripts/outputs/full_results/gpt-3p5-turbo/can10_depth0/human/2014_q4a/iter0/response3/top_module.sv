module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

// Define internal signals and registers
reg Q_next;
reg [1:0] s_next;

// Define flip-flops
always @(posedge clk) begin
	if (L)
		Q <= R;
	else
		Q <= Q_next;
end

// Define multiplexers
always @(E or Q or w) begin
	if (E)
		Q_next <= w;
	else
		Q_next <= Q;
end

endmodule
