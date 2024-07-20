module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	
	// define the states
	typedef enum logic [3:0] {
		A,
		B,
		C,
		S10,
		S11,
		S20,
		S21,
		S22
	} state_type;
	
	// create state register
	reg [3:0] state_reg, state_next;
	
	// assign initial state
	always @(posedge clk or posedge reset) begin
		if (reset)
			state_reg <= A;
		else
			state_reg <= state_next;
	end
	
	// define next state logic
	always @(state_reg or s or w) begin
		case(state_reg)
			
			A: if (s) state_next = B;
			   else state_next = A;
			
			B: if (w) state_next = S11;
			   else state_next = S10;
			   
			C: if (w) state_next = S11;
			   else state_next = S10;
			   
			S10: if (w) state_next = S21;
			     else state_next = S20;
			   
			S11: if (w) state_next = S22;
			     else state_next = S21;
			   
			S20: state_next = B;
			
			S21: if (w) state_next = C;
			     else state_next = B;
			   
			S22: if (w) state_next = B;
			     else state_next = C;
			
			default: state_next = A;
		endcase
	end
	
	// assign output based on current state
	always @(state_reg) begin
		case(state_reg)
			A: z = 0;
			B: z = 0;
			C: z = 0;
			S10: z = 0;
			S11: z = 0;
			S20: z = 1;
			S21: z = 1;
			S22: z = 1;
			
			default: z = 0;
		endcase
	end
	
endmodule
