module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State Encoding
	typedef enum logic [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;
	
	state_t state, next_state;
	
	// State transition logic (combinational)
	always_comb begin
		case (state)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			
			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
			
			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
			end
			
			D: begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
			
			default: next_state = A;
		endcase
	end
	
	// State flip-flops (sequential)
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
		end
		
	// Output logic (Moore Machine)
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			out <= 1'b0;
		else begin
			case (state)
				A, B, C: out <= 1'b0;
				D: out <= 1'b1;
				default: out <= 1'b0;
			endcase
		end
	end
endmodule
