module fsm (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

// State codes
parameter [1:0]
	A = 2'b00,
	B = 2'b01,
	C = 2'b10,
	D = 2'b11;

// Declare state register
reg [1:0] state;

// State flip-flop
always @(posedge clk, negedge resetn)
begin
	if (~resetn)
		state <= A;
	else
		state <= nextState;
end

// Output generation
always @(state, r)
begin
	case(state)
		A: begin
			if (r[1] & ~r[2] & ~r[3])
				g <= 3'b001;
			else if (~r[1] & ~r[2] & ~r[3])
				g <= 3'b000;
			else if (r[1])
				g <= 3'b010;
			else if (~r[1] & r[2])
				g <= 3'b100;
		end
		B: begin
			if (~r[1])
				g <= 3'b001;
			else if (r[1])
				g <= 3'b010;
		end
		C: begin
			if (~r[2])
				g <= 3'b010;
			else if (r[2])
				g <= 3'b100;
		end
		D: g <= 3'b000;
	endcase
end

// State transition logic
always @(state, r)
begin
	case(state)
		A: begin
			if (r[1])
				nextState = B;
			else if (r[2])
				nextState = C;
			else if (r[3])
				nextState = D;
			else
				nextState = A;
		end
		B: begin
			if (r[1])
				nextState = B;
			else
				nextState = A;
		end
		C: begin
			if (r[2])
				nextState = C;
			else
				nextState = A;
		end
		D: nextState = A;
	endcase
end

endmodule
module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	fsm fsm_inst (
		.clk(clk),
		.resetn(resetn),
		.r(r),
		.g(g)
	);
endmodule
