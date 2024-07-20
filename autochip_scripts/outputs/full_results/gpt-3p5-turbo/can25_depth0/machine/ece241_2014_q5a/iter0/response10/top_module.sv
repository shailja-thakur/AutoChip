module top_module (
	input clk,
	input areset,
	input x,
	output z
);
 
// defining the states using parameters
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;

// state register
reg [1:0] state;

// always block triggered on positive edge of clock and reset
always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= A;
	else
	begin
		case(state)
			A: state <= (x == 1'b1) ? C : A;
			B: state <= (x == 1'b1) ? B : C;
			C: state <= (x == 1'b1) ? B : C;
		endcase
	end
end

// output assignment
assign z = (state == C) ? 1'b1 : 1'b0;

endmodule
