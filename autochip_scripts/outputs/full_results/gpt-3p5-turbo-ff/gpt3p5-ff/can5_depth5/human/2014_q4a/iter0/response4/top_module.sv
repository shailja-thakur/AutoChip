module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	// Declare internal wires
	wire in_data;
	wire out_data;

	// Declare flip-flop
	reg D;

	// Declare multiplexers
	reg M;

	// Assign input data to multiplexer
	assign in_data = (L & R) | (E & w);

	// Assign output data from flip-flop to multiplexer
	assign out_data = Q;

	// Implementation of flip-flop
	always @(posedge clk) begin
		if (E) begin
			D <= in_data;
		end
	end

	// Implementation of multiplexer
	always @(posedge clk) begin
		if (L) begin
			M <= out_data;
		end
	end

	// Assign output of multiplexer to output Q
	always @(posedge clk) begin
		if (L) begin
			Q <= M;
		end
	end
endmodule
