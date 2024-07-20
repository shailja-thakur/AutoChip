module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	reg [1:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else begin
			case (state)
				0: begin
					if (s)
						state <= 1;
				end
				1: begin
					if (w)
						state <= 2;
					else
						state <= 1;
				end
				2: begin
					if (w)
						state <= 3;
					else
						state <= 4;
				end
				3: begin
					if (w)
						state <= 5;
					else
						state <= 4;
				end
				4: begin
					if (w)
						state <= 2;
					else
						state <= 1;
				end
				5: begin
					if (w)
						state <= 6;
					else
						state <= 4;
				end
				6: begin
					if (w)
						state <= 3;
					else
						state <= 4;
				end
			endcase
		end
	end

	always @(posedge clk) begin
		case (state)
			1, 2, 3, 4: z <= 0;
			5, 6: z <= 1;
			default: z <= 0;
		endcase
	end
endmodule
