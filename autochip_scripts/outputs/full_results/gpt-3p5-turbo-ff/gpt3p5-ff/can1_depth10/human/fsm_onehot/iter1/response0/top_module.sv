module top_module (
	input in,
	input [9:0] state,
	output wire [9:0] next_state,
	output wire out1,
	output wire out2);

	// Define the state encoding
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

	// State transition logic
	always @(*)
	begin
		case (state)
			S0: begin
				if (in == 0)
					next_state = S0;
				else
					next_state = S1;
			end
			
			S1: begin
				if (in == 0)
					next_state = S0;
				else
					next_state = S2;
			end
			
			S2: begin
				if (in == 0)
					next_state = S0;
				else
					next_state = S3;
			end
			
			S3: begin
				if (in == 0)
					next_state = S0;
				else
					next_state = S4;
			end
			
			S4: begin
				if (in == 0)
					next_state = S0;
				else
					next_state = S5;
			end
			
			S5: begin
				if (in == 0)
					next_state = S8;
				else
					next_state = S6;
			end
			
			S6: begin
				if (in == 0)
					next_state = S9;
				else
					next_state = S7;
			end
			
			S7: begin
				if (in == 0)
					next_state = S0;
				else
					next_state = S7;
			end
			
			S8: begin
				if (in == 0)
					next_state = S0;
				else
					next_state = S1;
			end
			
			S9: begin
				if (in == 0)
					next_state = S0;
				else
					next_state = S1;
			end
			
			default: next_state = S0;
		endcase
	end

	// Output logic
	always @(*)
	begin
		case (state)
			S0: begin
				out1 = 0;
				out2 = 0;
			end
			
			S7: begin
				out1 = 0;
				out2 = 1;
			end
			
			S8: begin
				out1 = 1;
				out2 = 0;
			end
			
			S9: begin
				out1 = 1;
				out2 = 1;
			end
			
			default: begin
				out1 = 0;
				out2 = 0;
			end
		endcase
	end

endmodule
