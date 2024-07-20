module top_module(
	input clk,
	input reset,
	output reg [31:0] q
);

	// Internal wires
	wire tap32, tap22, tap2, tap1;

	// Internal registers
	reg [31:0] d, q_reg;

	// Next-state logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			d <= 32'h1;
			q_reg <= 32'h1;
		end else begin
			d <= {q_reg[30:0], tap32 ^ tap22 ^ tap2 ^ tap1};
			q_reg <= d;
		end
	end

	// Output logic
	assign q = q_reg;

	// Tap calculations
	assign tap32 = q_reg[31];
	assign tap22 = q_reg[21];
	assign tap2 = q_reg[1];
	assign tap1 = q_reg[0];

endmodule
