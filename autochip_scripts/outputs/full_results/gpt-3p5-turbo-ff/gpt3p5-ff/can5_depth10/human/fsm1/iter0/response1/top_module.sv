module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
wire out;

// State declarations
parameter B = 2'b00;
parameter A = 2'b01;

// Next-state logic
always @(posedge clk, posedge areset)
begin
	if (areset)
		state <= B;
	else
		case (state)
			B: state <= (in) ? B : A;
			A: state <= (in) ? A : B;
		endcase
end

// Output logic
assign out = (state == A) ? 1'b1 : 1'b0;

endmodule
