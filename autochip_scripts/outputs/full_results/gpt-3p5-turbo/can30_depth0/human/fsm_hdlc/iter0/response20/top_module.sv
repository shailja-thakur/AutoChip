module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	// States of the FSM
	parameter S0 = 2'b00;		// Idle state
	parameter S1 = 2'b01;		// 1st 1 detected
	parameter S2 = 2'b10;		// 6 1s detected

	reg [1:0] state;			// State register
	reg [2:0] consecutive_ones;	// Counter for consecutive 1s

	always @(posedge clk) begin
		if (reset) begin			// Reset FSM
			state <= S0;
			consecutive_ones <= 3'b000;
			disc <= 1'b0;
			flag <= 1'b0;
			err <= 1'b0;
		end else begin
			case (state)
				S0: begin
					if (in == 1'b1) begin
						state <= S1;
						consecutive_ones <= 3'b001;
					end
				end
				S1: begin
					if (in == 1'b1) begin
						state <= S2;
						consecutive_ones <= consecutive_ones + 1;
					end else begin
						state <= S0;
						consecutive_ones <= 3'b000;
					end
				end
				S2: begin
					if (in == 1'b0) begin
						state <= S0;
						consecutive_ones <= 3'b000;
					end else if (in == 1'b1) begin
						if (consecutive_ones >= 3'b110) begin
							state <= S0;
							consecutive_ones <= 3'b000;
							err <= 1'b1;
						end else begin
							state <= S2;
							consecutive_ones <= consecutive_ones + 1;
						end
					end
				end
				default: begin
					state <= S0;
					consecutive_ones <= 3'b000;
				end
			endcase
		end
	end

	// Output assignment
	always @(state or consecutive_ones) begin
		case (state)
			S0: begin
				disc <= 1'b0;
				flag <= 1'b0;
				err <= 1'b0;
			end
			S1: begin
				disc <= 1'b0;
				flag <= 1'b0;
				err <= 1'b0;
			end
			S2: begin
				if (consecutive_ones == 3'b110)
					disc <= 1'b1;
				else if (consecutive_ones == 3'b111)
					flag <= 1'b1;
				else begin
					disc <= 1'b0;
					flag <= 1'b0;
				end
				err <= 1'b0;
			end
			default: begin
				disc <= 1'b0;
				flag <= 1'b0;
				err <= 1'b0;
			end
		endcase
	end

endmodule
