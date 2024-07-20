module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	reg [2:0] state;

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 0;
		else
		begin
			case (state)
				0: if (w) state <= 0; else state <= 1;
				1: if (w) state <= 3; else state <= 2;
				2: if (w) state <= 3; else state <= 4;
				3: if (w) state <= 0; else state <= 5;
				4: if (w) state <= 5; else state <= 3;
				5: if (w) state <= 2; else state <= 3;
				default: state <= 0;
			endcase
		end
	end

	always @(state)
	begin
		case (state)
			0: z <= 0;
			1: z <= 0;
			2: z <= 0;
			3: z <= 0;
			4: z <= 0;
			5: z <= 1;
			default: z <= 0;
		endcase
	end
	
endmodule
