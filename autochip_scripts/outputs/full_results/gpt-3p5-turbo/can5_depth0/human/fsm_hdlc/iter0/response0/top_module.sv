module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);


	reg [2:0] state;
	parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 = 3'b110, 
	S7 = 3'b111;

	always @(posedge clk) begin
		if (reset) begin
			state <= S0;
		end else begin
			case(state)
				S0: begin
					if (in)
						state <= S1;
					else
						state <= S0;
				end
				S1: begin
					if (in)
						state <= S2;
					else
						state <= S0;
				end
				S2: begin
					if (in)
						state <= S3;
					else
						state <= S0;
				end
				S3: begin
					if (in)
						state <= S4;
					else
						state <= S0;
				end
				S4: begin
					if (in)
						state <= S5;
					else
						state <= S0;
				end
				S5: begin
					if (in)
						state <= S6;
					else
						state <= S0;
				end
				S6: begin
					if (in)
						state <= S7;
					else
						state <= S0;
				end
				S7: begin
					if (in)
						state <= S7;
					else
						state <= S0;
				end
			endcase
		end
	end

	always @(state) begin
		case(state)
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
				disc <= 1'b0;
				flag <= 1'b0;
				err <= 1'b0;
			end
			S3: begin
				disc <= 1'b0;
				flag <= 1'b0;
				err <= 1'b0;
			end
			S4: begin
				disc <= 1'b0;
				flag <= 1'b0;
				err <= 1'b0;
			end
			S5: begin
				disc <= 1'b0;
				flag <= 1'b0;
				err <= 1'b0;
			end
			S6: begin
				disc <= 1'b1;
				flag <= 1'b0;
				err <= 1'b0;
			end
			S7: begin
				disc <= 1'b0;
				flag <= 1'b1;
				err <= 1'b0;
			end
		endcase
	end
endmodule
