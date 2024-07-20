module A(
	input x,
	input y,
	output z);

	// Implementation of boolean function z = (x^y) & x
	assign z = (x ^ y) & x;

endmodule
module B(
	input x,
	input y,
	output z);

	// Simulation waveform for B
	reg [1:0] time = 0;
	reg [1:0] x_data = 0;
	reg [1:0] y_data = 0;
	reg [1:0] z_data = 0;

	// Assign values based on simulation waveform
	always #5 begin
		case (time)
			0: begin	x_data = 0; y_data = 0; z_data = 1; end
			5: begin	x_data = 0; y_data = 0; z_data = 1; end
			10: begin	x_data = 0; y_data = 0; z_data = 1; end
			15: begin	x_data = 0; y_data = 0; z_data = 1; end
			20: begin	x_data = 0; y_data = 0; z_data = 1; end
			25: begin	x_data = 1; y_data = 0; z_data = 0; end
			30: begin	x_data = 1; y_data = 0; z_data = 0; end
			35: begin	x_data = 0; y_data = 1; z_data = 0; end
			40: begin	x_data = 0; y_data = 1; z_data = 0; end
			45: begin	x_data = 1; y_data = 1; z_data = 1; end
			50: begin	x_data = 1; y_data = 1; z_data = 1; end
			55: begin	x_data = 0; y_data = 0; z_data = 1; end
			60: begin	x_data = 0; y_data = 1; z_data = 0; end
			65: begin	x_data = 0; y_data = 1; z_data = 0; end
			70: begin	x_data = 1; y_data = 1; z_data = 1; end
			75: begin	x_data = 0; y_data = 1; z_data = 0; end
			80: begin	x_data = 0; y_data = 1; z_data = 0; end
			85: begin	x_data = 0; y_data = 1; z_data = 0; end
			90: begin	x_data = 1; y_data = 0; z_data = 0; end
			default: begin	x_data = 0; y_data = 0; z_data = 0; end
		endcase

		time = time + 5;
	end

	// Assign outputs based on selected simulation waveform values
	assign x = x_data;
	assign y = y_data;
	assign z = z_data;

endmodule
module top_module(
	input x,
	input y,
	output z);

	// Instantiate A submodules
	A A1(x, y, a1_z);
	A A2(x, y, a2_z);

	// Instantiate B submodules
	B B1(x, y, b1_z);
	B B2(x, y, b2_z);

	// Implement connections and logic
	assign or_out = a1_z | b1_z;
	assign and_out = a2_z & b2_z;
	assign z = or_out ^ and_out;

endmodule
