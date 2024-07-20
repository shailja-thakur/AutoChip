module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// Define the states
	typedef enum logic [2:0] {
		A,
		B,
		C,
		D,
		E,
		F
	} state_type;
	
	// Define state variables
	reg [2:0] curr_state, next_state;
	
	// Define output signals
	
	assign z = (curr_state == E || curr_state == F) ? 1'b1 : 1'b0;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			curr_state <= A;
		else
			curr_state <= next_state;
	end
	
	always @(curr_state, w) begin
		case (curr_state)
			A: next_state = w ? B : A;
			B: next_state = w ? C : D;
			C: next_state = w ? E : D;
			D: next_state = w ? F : A;
			E: next_state = w ? E : D;
			F: next_state = w ? C : D;
			default: next_state = A;
		endcase
	end
	
endmodule
module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// Define the states
	typedef enum logic [2:0] {
		A,
		B,
		C,
		D,
		E,
		F
	} state_type;
	
	// Define state variables
	reg [2:0] curr_state, next_state;
	
	// Define output signals
	
	assign z = (curr_state == E || curr_state == F) ? 1'b1 : 1'b0;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			curr_state <= A;
		else
			curr_state <= next_state;
	end
	
	always @(curr_state, w) begin
		case (curr_state)
			A: next_state = w ? B : A;
			B: next_state = w ? C : D;
			C: next_state = w ? E : D;
			D: next_state = w ? F : A;
			E: next_state = w ? E : D;
			F: next_state = w ? C : D;
			default: next_state = A;
		endcase
	end
	
endmodule
