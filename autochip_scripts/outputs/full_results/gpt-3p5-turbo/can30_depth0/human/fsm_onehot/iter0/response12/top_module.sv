module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Define the states
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

	// Define the outputs
	reg out1;
	reg out2;

	// Define the next state
	reg [9:0] next_state;

	// State transition logic
	always @ (state or in) begin
		case (state)
			S0: begin
				if (in == 1'b0) begin
					next_state = S0;
				end else begin
					next_state = S1;
				end
			end

			S1: begin
				if (in == 1'b0) begin
					next_state = S0;
				end else begin
					next_state = S2;
				end
			end

			S2: begin
				if (in == 1'b0) begin
					next_state = S0;
				end else begin
					next_state = S3;
				end
			end

			S3: begin
				if (in == 1'b0) begin
					next_state = S0;
				end else begin
					next_state = S4;
				end
			end

			S4: begin
				if (in == 1'b0) begin
					next_state = S0;
				end else begin
					next_state = S5;
				end
			end

			S5: begin
				if (in == 1'b0) begin
					next_state = S8;
				end else begin
					next_state = S6;
				end
			end

			S6: begin
				if (in == 1'b0) begin
					next_state = S9;
				end else begin
					next_state = S7;
				end
			end

			S7: begin
				if ((in == 1'b0) || (state == S7)) begin
					next_state = S0;
				end else begin
					next_state = S7;
				end
			end

			S8: begin
				if (in == 1'b0) begin
					next_state = S0;
				end else begin
					next_state = S1;
				end
			end

			S9: begin
				if (in == 1'b0) begin
					next_state = S0;
				end else begin
					next_state = S1;
				end
			end

		endcase
	end

	// Output logic
	always @ (state) begin
		case (state)
			S0: begin
				out1 = 1'b0;
				out2 = 1'b0;
			end

			S1: begin
				out1 = 1'b0;
				out2 = 1'b0;
			end

			S2: begin
				out1 = 1'b0;
				out2 = 1'b0;
			end

			S3: begin
				out1 = 1'b0;
				out2 = 1'b0;
			end

			S4: begin
				out1 = 1'b0;
				out2 = 1'b0;
			end

			S5: begin
				out1 = 1'b0;
				out2 = 1'b0;
			end

			S6: begin
				out1 = 1'b0;
				out2 = 1'b0;
			end

			S7: begin
				out1 = 1'b0;
				out2 = 1'b1;
			end

			S8: begin
				out1 = 1'b1;
				out2 = 1'b0;
			end

			S9: begin
				out1 = 1'b1;
				out2 = 1'b1;
			end

		endcase
	end

endmodule
