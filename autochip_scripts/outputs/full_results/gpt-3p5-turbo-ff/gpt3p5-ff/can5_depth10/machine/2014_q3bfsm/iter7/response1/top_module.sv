module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;

	always @(posedge clk or posedge reset) begin
		if (reset) 
            state <= A;
		else
            case(state)
				A: state <= x ? B : A;
				B: state <= x ? E : B;
				C: state <= x ? B : C;
				D: state <= x ? C : B;
				E: state <= x ? E : D;
			endcase
	end

	always @* begin
		z = (state == D || state == E) ? 1'b1 : 1'b0;
	end

endmodule
