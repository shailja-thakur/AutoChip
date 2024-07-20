module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// Define state codes
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
parameter E = 2'b100;
parameter F = 2'b101;

reg [1:0] state;
wire [1:0] next_state;

// State table
always @(state or w) begin
	case(state)
		A: begin
			if (w)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if (w)
				next_state = C;
			else
				next_state = D;
		end
		C: begin
			if (w)
				next_state = E;
			else
				next_state = D;
		end
		D: begin
			if (w)
				next_state = F;
			else
				next_state = A;
		end
		E: begin
			if (w)
				next_state = E;
			else
				next_state = D;
		end
		F: begin
			if (w)
				next_state = C;
			else
				next_state = D;
		end
	endcase
end

// State flip-flop
always @(posedge clk or posedge reset) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

// Continuous assignment for output z
assign z = (state == E || state == F);

endmodule
