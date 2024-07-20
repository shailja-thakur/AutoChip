module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State parameter
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// State register
	reg [1:0] state;
	
	// Next state logic
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= A;
		else
		begin
			case (state)
				A: state <= (in) ? B : A;
				B: state <= (in) ? B : C;
				C: state <= (in) ? D : A;
				D: state <= (in) ? B : C;
			endcase
		end
	end
	
	// Output logic
	always @*
	begin
		out = (state == D) ? 1'b1 : 1'b0;
	end
	
endmodule
