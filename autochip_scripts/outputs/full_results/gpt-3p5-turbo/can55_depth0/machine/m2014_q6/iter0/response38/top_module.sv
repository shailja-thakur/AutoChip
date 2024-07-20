module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	reg [2:0] state;

	always @(posedge clk) begin
		if (reset)
			state <= 3'b000;
		else begin
			case(state)
				3'b000: if (w) state <= 3'b000; else state <= 3'b001;
				3'b001: if (w) state <= 3'b011; else state <= 3'b010;
				3'b010: if (w) state <= 3'b011; else state <= 3'b100;
				3'b011: if (w) state <= 3'b000; else state <= 3'b101;
				3'b100: if (w) state <= 3'b000; else state <= 3'b100;
				3'b101: if (w) state <= 3'b011; else state <= 3'b110;
				3'b110: if (w) state <= 3'b011; else state <= 3'b100;
				default: state <= 3'b000;
			endcase
		end
	end

	assign z = (state == 3'b101 || state == 3'b110) ? 1'b1 : 1'b0;

endmodule
