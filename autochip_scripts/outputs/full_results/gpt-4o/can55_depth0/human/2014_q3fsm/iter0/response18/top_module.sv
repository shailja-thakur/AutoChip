module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	
	// Define states
	typedef enum reg [1:0] {A, B, C, D} state_t;
	state_t state, next_state;

	// Counter for 'w'
	reg [1:0] w_count;
	
	// State Transition
	always @(posedge clk) begin
		if (reset) begin
			state <= A;
			w_count <= 2'b00;
			z <= 0;
		end
		else begin
			state <= next_state;

			// Update w_count when in state B
			if (state == B) begin
				if (w)
					w_count <= w_count + 1;
			end
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: begin
				if (s)
					next_state = B;
				else
					next_state = A;
				z = 0;
			end
			B: begin
				next_state = C;
				z = 0;
			end
			C: begin
				next_state = D;
				z = 0;
			end
			D: begin
				if (w_count == 2'b10) 
					z = 1;
				else
					z = 0;
				
                if (s)
					next_state = B;
				else
					next_state = A;
			end
			default: begin
				next_state = A;
				z = 0;
			end
		endcase
	end
endmodule
