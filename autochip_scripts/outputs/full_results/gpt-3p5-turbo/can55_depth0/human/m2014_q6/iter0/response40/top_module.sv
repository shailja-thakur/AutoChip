module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b00;
	else
		state <= next_state;
end

always @(state or w) begin
	case (state)
		3'b000: next_state = (w) ? 3'b00 : 3'b01;
		3'b001: next_state = (w) ? 3'b11 : 3'b10;
		3'b010: next_state = (w) ? 3'b10 : 3'b11;
		3'b011: next_state = (w) ? 3'b11 : 3'b00;
		3'b100: next_state = (w) ? 3'b01 : 3'b10;
		3'b101: next_state = (w) ? 3'b10 : 3'b11;
		3'b110: next_state = (w) ? 3'b11 : 3'b11;
		3'b111: next_state = (w) ? 3'b10 : 3'b11;
	endcase
end

always @(state) begin
	case (state)
		3'b000: z = 1'b0;
		3'b001: z = 1'b0;
		3'b010: z = 1'b0;
		3'b011: z = 1'b0;
		3'b100: z = 1'b0;
		3'b101: z = 1'b0;
		3'b110: z = 1'b1;
		3'b111: z = 1'b0;
	endcase
end

endmodule
