module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	reg [1:0] state, next_state;
	
	// State Assignments
	localparam A = 2'b00;
	localparam B = 2'b01;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= B;
		end else begin
			state <= next_state; // Update state
		end
	end
	
	always @(*) begin
		case(state)
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
			end
			
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
		endcase
	end
	
	assign out = (state == B) ? 1'b1 : 1'b0;
	
endmodule
