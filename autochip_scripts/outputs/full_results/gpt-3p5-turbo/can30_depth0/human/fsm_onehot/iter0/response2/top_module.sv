module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Define the state bit variables
	reg s0, s1, s2, s3, s4, s5, s6, s7, s8, s9;

	// The combinational logic for deriving the next state
	always @* begin
		case (state)
			10'b0000000001: begin
				s0 = 1;
				s1 = 0;
				s2 = 0;
				s3 = 0;
				s4 = 0;
				s5 = 0;
				s6 = 0;
				s7 = 0;
				s8 = 0;
				s9 = 0;
			end
			10'b0000000010: begin
				s0 = 0;
				s1 = 1;
				s2 = 0;
				s3 = 0;
				s4 = 0;
				s5 = 0;
				s6 = 0;
				s7 = 0;
				s8 = 0;
				s9 = 0;
			end
			10'b0000000100: begin
				s0 = 0;
				s1 = 0;
				s2 = 1;
				s3 = 0;
				s4 = 0;
				s5 = 0;
				s6 = 0;
				s7 = 0;
				s8 = 0;
				s9 = 0;
			end
			10'b0000001000: begin
				s0 = 0;
				s1 = 0;
				s2 = 0;
				s3 = 1;
				s4 = 0;
				s5 = 0;
				s6 = 0;
				s7 = 0;
				s8 = 0;
				s9 = 0;
			end
			10'b0000010000: begin
				s0 = 0;
				s1 = 0;
				s2 = 0;
				s3 = 0;
				s4 = 1;
				s5 = 0;
				s6 = 0;
				s7 = 0;
				s8 = 0;
				s9 = 0;
			end
			10'b0000100000: begin
				s0 = 0;
				s1 = 0;
				s2 = 0;
				s3 = 0;
				s4 = 0;
				s5 = 1;
				s6 = 0;
				s7 = 0;
				s8 = 0;
				s9 = 0;
			end
			10'b0001000000: begin
				s0 = 0;
				s1 = 0;
				s2 = 0;
				s3 = 0;
				s4 = 0;
				s5 = 0;
				s6 = 1;
				s7 = 0;
				s8 = 0;
				s9 = 0;
			end
			10'b0010000000: begin
				s0 = 0;
				s1 = 0;
				s2 = 0;
				s3 = 0;
				s4 = 0;
				s5 = 0;
				s6 = 0;
				s7 = 1;
				s8 = 0;
				s9 = 0;
			end
			10'b0100000000: begin
				s0 = 0;
				s1 = 0;
				s2 = 0;
				s3 = 0;
				s4 = 0;
				s5 = 0;
				s6 = 0;
				s7 = 0;
				s8 = 1;
				s9 = 0;
			end
			10'b1000000000: begin
				s0 = 0;
				s1 = 0;
				s2 = 0;
				s3 = 0;
				s4 = 0;
				s5 = 0;
				s6 = 0;
				s7 = 0;
				s8 = 0;
				s9 = 1;
			end
			default: begin
				s0 = 0;
				s1 = 0;
				s2 = 0;
				s3 = 0;
				s4 = 0;
				s5 = 0;
				s6 = 0;
				s7 = 0;
				s8 = 0;
				s9 = 0;
			end
		endcase
	end

	// Assign next_state outputs
	assign next_state = {s0, s1, s2, s3, s4, s5, s6, s7, s8, s9};

	// The combinational logic for deriving the outputs out1 and out2
	always @* begin
		case (state)
			10'b0000000001, 10'b0000000010, 10'b0000000100, 10'b0000001000, 10'b0000010000, 10'b0000100000, 10'b0001000000, 10'b0010000000: begin
				out1 = 0;
				out2 = 0;
			end
			10'b0000000110, 10'b0000010110, 10'b1000000010, 10'b1000010010: begin
				out1 = 0;
				out2 = 1;
			end
			10'b0000000111, 10'b0000010111: begin
				out1 = 0;
				out2 = in;
			end
			10'b0000100110, 10'b0100100110, 10'b0010100110, 10'b1000010011, 10'b0100010010, 10'b0110010010, 10'b0100000010: begin
				out1 = 1;
				out2 = in;
			end
			default: begin
				out1 = 0;
				out2 = 0;
			end
		endcase
	end

endmodule
