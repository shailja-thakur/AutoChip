module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Define internal registers and wires
	reg [3:0] q0, q1, q2, q3;
	wire [3:0] ones, tens, hundreds, thousands;

	// Instantiate the BCD counter for each digit
	BCD_counter U0(
		.clk(clk),
		.reset(reset),
		.enable(ena[0]),
		.q(ones)
	);

	BCD_counter U1(
		.clk(clk),
		.reset(reset),
		.enable(ena[1]),
		.q(tens)
	);

	BCD_counter U2(
		.clk(clk),
		.reset(reset),
		.enable(ena[2]),
		.q(hundreds)
	);

	BCD_counter U3(
		.clk(clk),
		.reset(reset),
		.enable(0), // No enable needed for thousands digit
		.q(thousands)
	);

	// Combine the BCD digits into the output register
	always@(posedge clk or posedge reset) begin
		if (reset) begin
			q0 <= 4'b0000;
			q1 <= 4'b0000;
			q2 <= 4'b0000;
			q3 <= 4'b0000;
		end else begin
			q0 <= ones;
			q1 <= tens;
			q2 <= hundreds;
			q3 <= thousands;
		end
	end

	// Assign the output register values to the module output
	assign q = {q3, q2, q1, q0};

endmodule
