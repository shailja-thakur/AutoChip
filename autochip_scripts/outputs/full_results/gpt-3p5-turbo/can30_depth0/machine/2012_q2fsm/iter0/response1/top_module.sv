module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	reg [2:0] state, next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // initial state is A
		else
			state <= next_state;
	end
	
	assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0; // set z to 1 when state is E or F
	
	always @(state or w) begin
		case (state)
			3'b000: next_state = (w == 1'b0) ? 3'b000 : 3'b001; // A transitions to B if w is 1, otherwise stays in A
			3'b001: next_state = (w == 1'b0) ? 3'b010 : 3'b011; // B transitions to C if w is 1, otherwise transitions to D
			3'b010: next_state = (w == 1'b0) ? 3'b011 : 3'b100; // C transitions to D if w is 0, otherwise transitions to E
			3'b011: next_state = (w == 1'b0) ? 3'b000 : 3'b101; // D transitions to A if w is 0, otherwise transitions to F
			3'b100: next_state = (w == 1'b0) ? 3'b011 : 3'b100; // E transitions to D if w is 0, otherwise stays in E
			3'b101: next_state = (w == 1'b0) ? 3'b011 : 3'b010; // F transitions to D if w is 0, otherwise transitions to C
			default: next_state = 3'b000; // default case set to A
		endcase
	end
endmodule
