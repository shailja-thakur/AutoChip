module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// State encoding
	typedef enum reg [2:0] {
		S000 = 3'b000,
		S001 = 3'b001,
		S010 = 3'b010,
		S011 = 3'b011,
		S100 = 3'b100
	} state_t;
	
	state_t current_state, next_state;
	
	// State transition logic
	always @(*) begin
		case (current_state)
			S000: next_state = (x) ? S001 : S000;
			S001: next_state = (x) ? S100 : S001;
			S010: next_state = (x) ? S001 : S010;
			S011: next_state = (x) ? S010 : S001;
			S100: next_state = (x) ? S100 : S011;
			default: next_state = S000;
		endcase
	end
	
	// Output logic
	always @(*) begin
		case (current_state)
			S011, S100: z = 1;
			default: z = 0;
		endcase
	end
	
	// State flip-flops with synchronous reset
	always @(posedge clk) begin
		if (reset)
			current_state <= S000;
		else
			current_state <= next_state;
	end
	
endmodule
