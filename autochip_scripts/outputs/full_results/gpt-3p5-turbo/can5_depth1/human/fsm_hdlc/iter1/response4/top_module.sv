module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	reg [2:0] state;
	initial begin
		state = 0;
		disc = 0;
		flag = 0;
		err = 0;
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
		end else begin
			case (state)
				0: begin
					if (in) begin
						state <= 1;
					end
				end
				1: begin
					if (in) begin
						state <= 2;
					end else begin
						state <= 0;
					end
				end
				2: begin
					if (in) begin
						state <= 3;
					end else begin
						state <= 4;
					end
				end
				3: begin
					if (in) begin
						state <= 3;
					end else begin
						state <= 0;
						disc <= 1;
					end
				end
				4: begin
					if (in) begin
						state <= 5;
					end else begin
						state <= 0;
					end
				end
				5: begin
					if (in) begin
						state <= 6;
					end else begin
						state <= 0;
						flag <= 1;
					end
				end
				6: begin
					if (in) begin
						state <= 3;
					end else begin
						state <= 7;
					end
				end
				7: begin
					state <= 0;
					err <= 1;
				end
				default: begin
					state <= 0;
				end
			endcase
		end
	end
	
endmodule
