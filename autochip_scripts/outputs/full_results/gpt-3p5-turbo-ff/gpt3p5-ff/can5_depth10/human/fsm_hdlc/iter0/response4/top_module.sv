module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

reg [2:0] state;
reg disc, flag, err;

parameter IDLE = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b100;
parameter ERROR = 3'b110;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		disc <= 0;
		flag <= 0;
		err <= 0;
	end else begin
		case (state)
			IDLE: begin
				if (in) begin
					state <= S1;
				end
			end
			S1: begin
				if (in) begin
					state <= S2;
				end else begin
					state <= IDLE;
				end
			end
			S2: begin
				if (in) begin
					state <= S3;
				end else begin
					state <= IDLE;
				end
			end
			S3: begin
				if (in) begin
					state <= ERROR;
					err <= 1;
				end else begin
					state <= IDLE;
					flag <= 1;
				end
			end
			ERROR: begin
				if (~in) begin
					state <= IDLE;
					err <= 0;
				end
			end
		endcase
	end
end

endmodule
