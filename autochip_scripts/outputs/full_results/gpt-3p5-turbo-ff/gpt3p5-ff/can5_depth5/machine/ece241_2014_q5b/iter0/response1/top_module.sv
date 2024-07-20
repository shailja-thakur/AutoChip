module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	parameter A = 0;
	parameter B = 1;
	reg [1:0] state;

	always @(posedge clk or posedge areset) begin
	    if (areset == 1'b1)
	        state <= A;
        else begin
	        case(state)
		        A: state <= (x == 1'b1) ? B : A;
		        B: state <= B;
		    endcase
		end
	end

	assign z = (state == A && x) || (state == B && !x);

endmodule
