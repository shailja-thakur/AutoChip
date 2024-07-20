module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state, next_state;

	parameter IDLE = 0, S1 = 1, S2 = 2, S3 = 3;
	parameter FLAG = 1'b1, NOT_FLAG = 1'b0;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			disc <= NOT_FLAG;
			flag <= NOT_FLAG;
			err <= NOT_FLAG;
		end else begin
			state <= next_state;
			disc <= NOT_FLAG;
			flag <= NOT_FLAG;
			err <= NOT_FLAG;

			case (state)
				IDLE:
					if (in) begin
						next_state <= S1;
					end else begin
						next_state <= IDLE;
					end
				S1:
					if (in) begin
						next_state <= S2;
					end else begin
						next_state <= IDLE;
					end
				S2:
					if (in) begin
						next_state <= S3;
					end else begin
						next_state <= IDLE;
					end
				S3:
					if (in) begin
						next_state <= S3;
						err <= FLAG;
					end else begin
						next_state <= IDLE;
						flag <= FLAG;
					end
			endcase
		end
	end

endmodule
