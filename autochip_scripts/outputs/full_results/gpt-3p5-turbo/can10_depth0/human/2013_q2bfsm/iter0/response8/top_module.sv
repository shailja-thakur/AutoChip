module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

// Define the states
parameter A = 1, B = 2, C = 3, D = 4;

// Define the current state variable
reg [3:0] state;

// Define the next state variable
reg [3:0] next_state;

// Define the output f
reg f;

// Define the output g
reg g;

// Synchronous reset
always @(posedge clk or negedge resetn)
begin
	if (~resetn)
		state <= A;
	else
		state <= next_state;
end

// Combinational logic for next state and output assignments
always @*
begin
	// Default assignments
	next_state = state;
	f = 0;
	g = 0;

	case(state)
		A:
		begin
			if (~resetn)
				next_state = A;
			else if (x == 1'b1 && y == 1'b1)
				next_state = B;
			else if (x == 1'b1)
				next_state = C;
		end

		B:
		begin
			if (~resetn)
				next_state = A;
			else
				next_state = D;
			f = 1;
		end

		C:
		begin
			if (~resetn)
				next_state = A;
			else if (x == 1'b0)
				next_state = A;
			else if (x == 1'b1)
				next_state = C;
		end

		D:
		begin
			if (~resetn)
				next_state = A;
			else if (y == 1'b1)
			begin
				next_state = D;
				g = 1;
			end
			else if (y == 1'b0)
				next_state = A;
		end
	endcase
end

endmodule
