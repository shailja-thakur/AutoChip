module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// State encoding
	reg [2:0] state, next_state;
	localparam A = 3'b000,
	           B = 3'b001,
	           C = 3'b010,
	           D = 3'b011,
	           E = 3'b100,
	           F = 3'b101;
	
	// State transition logic (Next state logic)
	always @(*) begin
		case (state)
			A: next_state = (w == 1'b0) ? A : B;
			B: next_state = (w == 1'b0) ? D : C;
			C: next_state = (w == 1'b0) ? D : E;
			D: next_state = (w == 1'b0) ? A : F;
			E: next_state = (w == 1'b0) ? D : E;
			F: next_state = (w == 1'b0) ? D : C;
			default: next_state = A; // Default state
		endcase
	end
	
	// State flip-flops (Sequential logic)
	always @(posedge clk) begin
		if (reset) begin
			state <= A; // Reset state to A
		end else begin
			state <= next_state;
		end
	end
	
	// Output logic
	assign z = (state == E) | (state == F);
	
endmodule
