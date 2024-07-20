module top_module (
	input clk,
	input areset,
	input x,
	output z
);
// Parameter to define the two states
parameter A = 2'b00;
parameter B = 2'b01;

// State register to track the current state
reg [1:0] state;

// Clock always block to handle state transitions
always @(posedge clk) begin
	if (areset)
		state <= A;
	else begin
		case (state)
			A: begin
				if (x)
					state <= B;
				else
					state <= A;
			end
			B: state <= B;
		endcase
	end
end

// Output always block to set the value of output z
always @(state or x) begin
	if ((state == A && x) || (state == B && !x))
		z <= 1;
	else
		z <= 0;
end

endmodule
