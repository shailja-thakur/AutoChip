module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b000;   // initial state A
	else begin
		case (state)
			3'b000: if (w == 0) state <= 3'b000; else state <= 3'b001;  // state A
			3'b001: if (w == 0) state <= 3'b011; else state <= 3'b010;  // state B
			3'b010: if (w == 0) state <= 3'b011; else state <= 3'b101;  // state C
			3'b011: if (w == 0) state <= 3'b000; else state <= 3'b110;  // state D
			3'b100: state <= 3'b011;  // state E
			3'b101: state <= 3'b010;  // state F
			default: state <= 3'b000;  // default to state A
		endcase
	end
end

assign z = (state == 3'b100) || (state == 3'b101);  // output z is 1 if state is E or F

endmodule
