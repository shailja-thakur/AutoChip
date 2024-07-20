module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Define the state variables
	parameter S0 = 10'b0000000001;
	parameter S1 = 10'b0000000010;
	parameter S2 = 10'b0000000100;
	parameter S3 = 10'b0000001000;
	parameter S4 = 10'b0000010000;
	parameter S5 = 10'b0000100000;
	parameter S6 = 10'b0001000000;
	parameter S7 = 10'b0010000000;
	parameter S8 = 10'b0100000000;
	parameter S9 = 10'b1000000000;

	// Define the output variables
	reg out1;
	reg out2;

	always @* begin
		case(state)
			// S0 transitions
			S0: begin
				if(in == 0) begin
					next_state = S0;
					out1 = 0;
					out2 = 0;
				end else if(in == 1) begin
					next_state = S1;
					out1 = 0;
					out2 = 0;
				end
			end

			// S1 transitions
			S1: begin
				if(in == 0) begin
					next_state = S0;
					out1 = 0;
					out2 = 0;
				end else if(in == 1) begin
					next_state = S2;
					out1 = 0;
					out2 = 0;
				end
			end

			// S2 transitions
			S2: begin
				if(in == 0) begin
					next_state = S0;
					out1 = 0;
					out2 = 0;
				end else if(in == 1) begin
					next_state = S3;
					out1 = 0;
					out2 = 0;
				end
			end

			// S3 transitions
			S3: begin
				if(in == 0) begin
					next_state = S0;
					out1 = 0;
					out2 = 0;
				end else if(in == 1) begin
					next_state = S4;
					out1 = 0;
					out2 = 0;
				end
			end

			// S4 transitions
			S4: begin
				if(in == 0) begin
					next_state = S0;
					out1 = 0;
					out2 = 0;
				end else if(in == 1) begin
					next_state = S5;
					out1 = 0;
					out2 = 0;
				end
			end

			// S5 transitions
			S5: begin
				if(in == 0) begin
					next_state = S8;
					out1 = 0;
					out2 = 0;
				end else if(in == 1) begin
					next_state = S6;
					out1 = 0;
					out2 = 0;
				end
			end

			// S6 transitions
			S6: begin
				if(in == 0) begin
					next_state = S9;
					out1 = 0;
					out2 = 0;
				end else if(in == 1) begin
					next_state = S7;
					out1 = 0;
					out2 = 0;
				end
			end

			// S7 transitions
			S7: begin
				if(in == 0) begin
					next_state = S0;
					out1 = 0;
					out2 = 1;
				end else if(in == 1) begin
					next_state = S7;
					out1 = 0;
					out2 = 1;
				end
			end

			// S8 transitions
			S8: begin
				if(in == 0) begin
					next_state = S0;
					out1 = 1;
					out2 = 0;
				end else if(in == 1) begin
					next_state = S1;
					out1 = 1;
					out2 = 0;
				end
			end

			// S9 transitions
			S9: begin
				if(in == 0) begin
					next_state = S0;
					out1 = 1;
					out2 = 1;
				end else if(in == 1) begin
					next_state = S1;
					out1 = 1;
					out2 = 1;
				end
			end
		endcase
	end
endmodule
