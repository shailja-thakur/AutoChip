module top_module (
	input clk,
	input in,
	input areset,
	output out
);

// Define the states using an enum
typedef enum logic [1:0] {
	A,
	B,
	C,
	D
} state_type;

// Define the internal state register
reg [1:0] state;

// Combinational logic to determine the next state
always_comb begin
	case (state)
		A: begin
			if (in)
				state = B;
			else
				state = A;
		end
		B: begin
			if (in)
				state = B;
			else
				state = C;
		end
		C: begin
			if (in)
				state = D;
			else
				state = A;
		end
		D: begin
			if (in)
				state = B;
			else
				state = C;
		end
		default: state = A;
	endcase
end

// Logic to set the output signal
assign out = (state == D) ? 1 : 0;

// Update the state register on the rising edge of the clock
always_ff @(posedge clk or posedge areset) begin
	if (areset)
		state <= A;
	else
		state <= state;
end

endmodule
