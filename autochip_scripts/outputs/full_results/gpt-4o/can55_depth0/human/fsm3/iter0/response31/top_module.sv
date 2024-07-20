module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
	
	// Define states using localparam
	localparam A = 2'b00, 
	           B = 2'b01, 
	           C = 2'b10, 
	           D = 2'b11;

	reg [1:0] state, next_state;
	
	// State transition on the positive edge of clk or asynchronously reset on areset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A; // Asynchronous reset to state A
		end else begin
			state <= next_state;
		end
	end
	
	// Next state logic
	always @(*) begin
		case (state)
			A: next_state = (in == 1'b0) ? A : B;
			B: next_state = (in == 1'b0) ? C : B;
			C: next_state = (in == 1'b0) ? A : D;
			D: next_state = (in == 1'b0) ? C : B;
		    default: next_state = A;
		endcase
	end
	
	// Output logic based on the current state
	always @(*) begin
		case (state)
			A: out = 1'b0;
			B: out = 1'b0;
			C: out = 1'b0;
			D: out = 1'b1;
		    default: out = 1'b0;
		endcase
	end

endmodule
