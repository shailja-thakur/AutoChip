module top_module (
    input wire clk,
    input wire areset,
    input wire x,
    output wire z
);
	reg [1:0] state;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else begin
			case (state)
				A: state <= (x) ? B : A;
				B: state <= B;
			endcase
		end
	end

	assign z = (state == A && x) || (state == B && !x);
endmodule
