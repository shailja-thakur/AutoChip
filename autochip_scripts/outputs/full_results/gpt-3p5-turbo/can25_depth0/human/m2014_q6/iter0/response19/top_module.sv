module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	
	// Declare state variables	
	reg [2:0] state;
	reg [2:0] next_state;
	
	// Declare output	
	reg output;
	
	// Declare state transitions
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000; // Initialize state to A
			output <= 1'b0; // Initialize output to 0
		end else begin
			state <= next_state;
			output <= (state == 3'b010); // Output Z is 1 when state is E
		end
	end
	
	// Declare next state logic
	always @(*) begin
		case(state)
			3'b000: if (w) next_state = 3'b001; else next_state = 3'b000; // Transition from A to B or A
			3'b001: if (w) next_state = 3'b000; else next_state = 3'b011; // Transition from B to A or D
			3'b010: if (w) next_state = 3'b011; else next_state = 3'b010; // Transition from C to D or C
			3'b011: if (w) next_state = 3'b101; else next_state = 3'b011; // Transition from D to A or D
			3'b100: if (w) next_state = 3'b100; else next_state = 3'b100; // Transition from E to E
			3'b101: if (w) next_state = 3'b011; else next_state = 3'b100; // Transition from E to D or C
			3'b110: if (w) next_state = 3'b010; else next_state = 3'b011; // Transition from F to C or D
			3'b111: if (w) next_state = 3'b101; else next_state = 3'b101; // No valid transition from this state
		endcase
	end
	
endmodule
