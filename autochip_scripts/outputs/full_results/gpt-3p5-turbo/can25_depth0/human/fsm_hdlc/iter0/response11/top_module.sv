module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state;
	parameter START = 0, S0 = 1, S1 = 2, S2 = 3, S3 = 4, S4 = 5, ERROR = 6;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= START;
		end else begin
			case (state)
				START: begin
					if (in) begin
						state <= S1;
					end else begin
						state <= START;
					end
				end
				S0: begin
					if (in) begin
						state <= S1;
					end else begin
						state <= START;
					end
				end
				S1: begin
					if (in) begin
						state <= S2;
					end else begin
						state <= START;
					end
				end
				S2: begin
					if (in) begin
						state <= S3;
					end else begin
						state <= START;
					end
				end
				S3: begin
					if (in) begin
						state <= S4;
					end else begin
						state <= START;
					end
				end
				S4: begin
					if (in) begin
						state <= ERROR;
					end else begin
						state <= START;
					end
				end
				ERROR: begin
					if (in) begin
						state <= ERROR;
					end else begin
						state <= START;
					end
				end
			endcase
		end
	end

	always @(state) begin
		case (state)
			START: begin
				disc = 0;
				flag = 0;
				err = 0;
			end
			S0: begin
				disc = 0;
				flag = 0;
				err = 0;
			end
			S1: begin
				disc = 0;
				flag = 0;
				err = 0;
			end
			S2: begin
				disc = 0;
				flag = 0;
				err = 0;
			end
			S3: begin
				disc = 0;
				flag = 0;
				err = 0;
			end
			S4: begin
				disc = 0;
				flag = 1;
				err = 0;
			end
			ERROR: begin
				disc = 1;
				flag = 0;
				err = 1;
			end
		endcase
	end

endmodule
