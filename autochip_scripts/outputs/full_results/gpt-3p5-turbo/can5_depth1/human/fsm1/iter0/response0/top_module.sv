module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	parameter B = 1'b0;
	parameter A = 1'b1;
	reg current_state;    // Current state of the Moore machine

	always @(posedge clk or posedge areset)
	begin
		if (areset)
			current_state <= B;    // Asynchronous reset to state B
		else
		begin
			case (current_state)
				B: 
					if (in)
						current_state <= B;
					else
						current_state <= A;
				A:
					if (in)
						current_state <= A;
					else
						current_state <= B;
			endcase
		end
	end

	assign out = (current_state == A) ? 1'b1 : 1'b0;

endmodule
