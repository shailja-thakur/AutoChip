module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	// Define states
	enum {S0, S1, S2, S3} state;

	// Define outputs
	reg disc, flag, err;

	// Define internal signals
	reg in_prev;
	reg count;

	// Initialize state and outputs
	initial begin
		state = S0;
		disc = 0;
		flag = 0;
		err = 0;
	end

	// Clock edge sensitive process
	always @(posedge clk) begin
		// Reset on active high reset signal
		if (reset == 1) begin
			state <= S0;
			disc <= 0;
			flag <= 0;
			err <= 0;
		end
		else begin
			case (state)
				S0: begin
					if (in == 0) begin
						state <= S0;
						disc <= 0;
						flag <= 0;
						err <= 0;
					end
					else begin
						state <= S1;
						in_prev <= in;
						count <= 1;
					end
				end

				S1: begin
					if (in == 1) begin
						state <= S2;
						in_prev <= in;
						count <= 2;
					end
					else begin
						state <= S0;
						disc <= 0;
						flag <= 0;
						err <= 0;
					end
				end

				S2: begin
					if (in == 1) begin
						if (in_prev == 1) begin
							if (count >= 6) begin
								state <= S3;
								disc <= 0;
								flag <= 0;
								err <= 1;
							end
							else begin
								state <= S2;
								in_prev <= in;
								count <= count + 1;
							end
						end
						else begin
							state <= S2;
							in_prev <= in;
							count <= 2;
						end
					end
					else begin
						state <= S0;
						if (count == 5) begin
							disc <= 1;
							flag <= 0;
							err <= 0;
						end
						else begin
							disc <= 0;
							flag <= 0;
							err <= 0;
						end
					end
				end

				S3: begin
					if (in == 0) begin
						state <= S0;
						disc <= 0;
						flag <= 0;
						err <= 0;
					end
					else begin
						state <= S3;
						disc <= 0;
						flag <= 0;
						err <= 1;
					end
				end
			endcase
		end
	end
endmodule
