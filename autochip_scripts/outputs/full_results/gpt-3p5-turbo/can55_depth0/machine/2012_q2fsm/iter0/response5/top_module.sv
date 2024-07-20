module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

reg [2:0] state;

always @(posedge clk) begin
	if (reset) begin
		state <= 3'b000; // initial state A
		z <= 0;
	end else begin
		case (state)
			3'b000: if (w) state <= 3'b001; else state <= 3'b000; // state A
			3'b001: if (w) state <= 3'b010; else state <= 3'b011; // state B
			3'b010: if (w) state <= 3'b100; else state <= 3'b010; // state C
			3'b011: if (w) state <= 3'b111; else state <= 3'b000; // state D
			3'b100: if (w) state <= 3'b100; else state <= 3'b010; // state E
			3'b111: if (w) state <= 3'b010; else state <= 3'b110; // state F
			default: state <= 3'b000;
		endcase
	end
end

assign z = (state == 3'b100) || (state == 3'b111); // output z is 1 when state is E or F

endmodule
