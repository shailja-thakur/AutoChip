module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else begin
			case(state)
				0: if (w == 1)
						state <= 0;
				   else
				   		state <= 1;
				1: if (w == 1)
						state <= 3;
				   else
				   		state <= 0;
				2: if (w == 1)
						state <= 3;
				   else
				   		state <= 4;
				3: if (w == 1)
						state <= 1;
				   else
				   		state <= 5;
				4: if (w == 1)
						state <= 2;
				   else
				   		state <= 3;
				5: if (w == 1)
						state <= 4;
				   else
				   		state <= 3;
				default: state <= 0;
			endcase
		end
	end

	always @* begin
		case(state)
			0: z = 0;
			1: z = 1;
			2: z = 0;
			3: z = 1;
			4: z = w;
			5: z = 0;
			default: z = 0;
		endcase
	end

endmodule
