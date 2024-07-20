module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	parameter A = 0; // State A
	parameter B = 1; // State B
	
	reg [1:0] state; // State register
	
	always @(posedge clk or posedge areset) begin
		if (areset) // Asynchronous reset
			state <= A;
		else begin
			case (state)
				A: if (x) state <= B;
				   else state <= A;
				B: state <= B;
			endcase
		end
	end
	
	assign z = (state == A && x) || (state == B && !x);
	
endmodule
