module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state; // state register

	// state assignments
	parameter IDLE = 3'b000;
	parameter BEGIN_1 = 3'b001;
	parameter BEGIN_2 = 3'b010;
	parameter ERROR = 3'b011;
	parameter DISCARD = 3'b100;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			case (state)
				IDLE: begin
					if (in) begin
						state <= BEGIN_1;
					end else begin
						state <= IDLE;
					end
				end

				BEGIN_1: begin
					if (in) begin
						state <= BEGIN_2;
					end else begin
						state <= IDLE;
					end
				end

				BEGIN_2: begin
					if (in) begin
						state <= ERROR;
					end else begin
						state <= DISCARD;
					end
				end

				DISCARD: begin
					if (in) begin
						state <= BEGIN_1;
					end else begin
						state <= IDLE;
					end
				end

				ERROR: begin
					if (in) begin
						state <= ERROR;
					end else begin
						state <= IDLE;
					end
				end
			endcase
		end
	end

	// output assignments
	assign disc = (state == DISCARD) ? 1'b1 : 1'b0;
	assign flag = (state == BEGIN_2) ? 1'b1 : 1'b0;
	assign err = (state == ERROR) ? 1'b1 : 1'b0;

endmodule
