module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);
    
	// State encoding
	typedef enum logic [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;
    
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			A: begin
				if (r[1]) next_state = B;
				else if (r[2]) next_state = C;
				else next_state = A;
			end
			B: begin
				if (r[1]) next_state = B;
				else next_state = A;
			end
			C: begin
				if (r[2]) next_state = C;
				else next_state = A;
			end
			default: next_state = A; // default case should handle reset and any unexpected state
		endcase
	end
	
	// State flip-flops & synchronous reset
	always @(posedge clk) begin
		if (!resetn) state <= A;
		else state <= next_state;
	end
    
	// Output logic
	always @(*) begin
		case (state)
			A: begin
				g = 3'b000;
			end
			B: begin
				g = 3'b001; // grant to device 1
			end
			C: begin
				g = 3'b010; // grant to device 2
			end
			default: begin
				g = 3'b000; // default case should cover any unexpected scenario
			end
		endcase
	end
endmodule
