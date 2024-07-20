module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q
);

	// Internal wires
	wire [511:0] q_right_shifted;
	wire [511:0] q_left_shifted;
	wire [511:0] q_next;

	// Boundary conditions
	assign q[-1] = 0;
	assign q[512] = 0;

	// Right shift q by 1
	assign q_right_shifted = {q[511], q[511:1]};

	// Left shift q by 1
	assign q_left_shifted = {q[510:0], q[0]};

	// Compute q_next based on the rules of Rule 90
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q_next = q_left_shifted ^ (q & q_right_shifted);
			q <= q_next;
		end
	end

endmodule
