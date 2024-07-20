module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Create a wire for each 4-bit input of the multiplexer
	wire [3:0] in0, in1, in2, in3, in4, in5, in6, in7;

	// Assign the appropriate sections of the input vector to each wire
	assign in0 = in[3:0];
	assign in1 = in[7:4];
	assign in2 = in[11:8];
	assign in3 = in[15:12];
	assign in4 = in[19:16];
	assign in5 = in[23:20];
	assign in6 = in[27:24];
	assign in7 = in[31:28];

	// Create a wire to store the selected input
	wire [3:0] selected_in;

	// Create a case statement to select the appropriate input based on the sel signal
	always @* begin
		case(sel)
			0: selected_in = in0;
			1: selected_in = in1;
			2: selected_in = in2;
			3: selected_in = in3;
			4: selected_in = in4;
			5: selected_in = in5;
			6: selected_in = in6;
			7: selected_in = in7;
		endcase
	end

	// Assign the selected input to the output
	assign out = selected_in;
endmodule
