module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	reg [2:0] state;
	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= 3'b000;
		else begin
			case (state)
				3'b000: if (w) state <= 3'b001; else state <= 3'b010;
				3'b001: if (w) state <= 3'b001; else state <= 3'b011;
				3'b010: if (w) state <= 3'b100; else state <= 3'b010;
				3'b011: if (w) state <= 3'b100; else state <= 3'b011;
				3'b100: if (w) state <= 3'b101; else state <= 3'b110;
				3'b101: if (w) state <= 3'b101; else state <= 3'b011;
				3'b110: if (w) state <= 3'b100; else state <= 3'b010;
				default: state <= 3'b000;
			endcase
		end
	end

	always @(state) begin
		case (state)
			3'b000: z <= 1'b0;
			3'b001: z <= 1'b0;
			3'b010: z <= 1'b0;
			3'b011: z <= 1'b0;
			3'b100: z <= 1'b1;
			3'b101: z <= 1'b0;
			3'b110: z <= 1'b1;
			default: z <= 1'b0;
		endcase
	end

endmodule
