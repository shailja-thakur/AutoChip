module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

	reg [2:0] state;

	parameter IDLE = 0;
	parameter ONE = 1;
	parameter TWO = 2;
	parameter THREE = 3;
	parameter FOUR = 4;
	parameter FIVE = 5;
	parameter SIX = 6;
	parameter FLAG = 7;
	parameter ERROR = 8;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			case (state)
				IDLE: begin
					if (in) begin
						state <= ONE;
					end
				end
				ONE: begin
					if (in) begin
						state <= TWO;
					end else begin
						state <= IDLE;
					end
				end
				TWO: begin
					if (in) begin
						state <= THREE;
					end else begin
						state <= IDLE;
					end
				end
				THREE: begin
					if (in) begin
						state <= FOUR;
					end else begin
						state <= IDLE;
					end
				end
				FOUR: begin
					if (in) begin
						state <= FIVE;
					end else begin
						state <= IDLE;
					end
				end
				FIVE: begin
					if (in) begin
						state <= SIX;
					end else begin
						state <= IDLE;
					end
				end
				SIX: begin
					if (in) begin
						state <= FLAG;
					end else begin
						state <= IDLE;
					end
				end
				FLAG: begin
					if (in) begin
						state <= ERROR;
					end else begin
						state <= IDLE;
					end
				end
				ERROR: begin
					if (~in) begin
						state <= IDLE;
					end
				end
				default: state <= IDLE;
			endcase
		end
	end

	always @(posedge clk) begin
		disc <= 0;
		flag <= 0;
		err <= 0;

		case (state)
			FLAG: begin
				flag <= 1;
			end
			ONE: begin
				disc <= 1;
			end
			ERROR: begin
				err <= 1;
			end
		endcase
	end

endmodule
