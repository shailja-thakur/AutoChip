module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define state encoding
	parameter A = 1'b0;
	parameter B = 1'b1;
	
	reg [1:0] state, next_state;
	
	always @(posedge clk or negedge areset) begin
		if (areset == 0) begin
			state <= B;
		end else begin
			state <= next_state;
		end
	end
	
	always @(*) begin
		case (state)
			A: begin
				if (in == 1'b0)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (in == 1'b0)
					next_state = A;
				else
					next_state = B;
			end
		endcase
	end
	
	assign out = (state == A) ? 1'b1 : 1'b0;
	
endmodule
