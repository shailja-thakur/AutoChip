module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg [1:0] state, next_state;
	
	// Define states
	localparam A = 2'b00;
	localparam B = 2'b01;
	localparam C = 2'b10;
	localparam D = 2'b11;
	
	// State transition
	always @(*) begin
		case (state)
			A: next_state = in ? B : A;
			B: next_state = in ? B : C;
			C: next_state = in ? D : A;
			D: next_state = in ? B : C;
			default: next_state = A;
		endcase
	end
	
	// State register with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Output logic
	always @(*) begin
		case (state)
			A: out = 0;
			B: out = 0;
			C: out = 0;
			D: out = 1;
			default: out = 0;
		endcase
	end

endmodule
