module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	// Define states as parameters
	parameter S0 = 0;
	parameter S1 = 1;
	parameter S2 = 2;
	parameter S3 = 3;

	// Define internal signals
	reg [1:0] state;
	reg disc_reg, flag_reg, err_reg;
	reg previous_input;

	// Set initial state
	initial begin
		state = S0;
		disc_reg = 0;
		flag_reg = 0;
		err_reg = 0;
		previous_input = 0;
	end

	// Sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S0;
			disc_reg <= 0;
			flag_reg <= 0;
			err_reg <= 0;
			previous_input <= 0;
		end else begin
			previous_input <= in;  // Store previous input for comparison

			case (state)
				S0: begin
					if (previous_input == 0 && in == 1)
						state <= S1;
				end
				S1: begin
					if (previous_input == 1 && in == 1)
						state <= S2;
					else if (previous_input == 1 && in == 0)
						state <= S0;
				end
				S2: begin
					if (previous_input == 1 && in == 1)
						state <= S3;
					else if (previous_input == 0 && in == 0)
						state <= S0;
				end
				S3: begin
					if (previous_input == 1 && in == 1)
						state <= S3;
					else if (previous_input == 1 && in == 0)
						state <= S0;
					else if (previous_input == 0 && in == 1)
						state <= S1;
				end
			endcase
		end
	end

	// Output logic
	always @(state) begin
		case (state)
			S0: begin
				disc_reg = 0;
				flag_reg = 0;
				err_reg = 0;
			end
			S1: begin
				disc_reg = 0;
				flag_reg = 0;
				err_reg = 0;
			end
			S2: begin
				disc_reg = 1;
				flag_reg = 0;
				err_reg = 0;
			end
			S3: begin
				disc_reg = 0;
				flag_reg = 1;
				err_reg = 0;
			end
		endcase
	end

	// Output assignments
	assign disc = disc_reg;
	assign flag = flag_reg;
	assign err = err_reg;

endmodule
