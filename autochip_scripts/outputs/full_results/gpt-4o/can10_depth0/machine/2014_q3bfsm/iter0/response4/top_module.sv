module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// Define state encoding
	typedef enum reg [2:0] {
		A = 3'b000,
		B = 3'b001,
		C = 3'b010,
		D = 3'b011,
		E = 3'b100
	} state_t;
	
	// State register and next state variable
	state_t state, next_state;

	// Output logic
	always @(*) begin
		case (state)
			D: z = 1'b1;
			E: z = 1'b1;
			default: z = 1'b0;
		endcase
	end

	// State transition logic (combinational)
	always @(*) begin
		case (state)
			A: if (x) next_state = B; else next_state = A;
			B: if (x) next_state = E; else next_state = B;
			C: if (x) next_state = B; else next_state = C;
			D: if (x) next_state = C; else next_state = B;
			E: if (x) next_state = E; else next_state = D;
			default: next_state = A; // Shouldn't happen
		endcase
	end
	
	// State register update (sequential)
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

endmodule
