module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state, next_state;

// state assignment
localparam A = 2'b00;
localparam B = 2'b01;

// initial state
initial begin
	state <= A;
end

// synchronous state transition
always @(posedge clk, posedge reset) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

// next state logic
always @(state, w) begin
	case (state)
		A: begin
			if (s)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if (w)
				next_state = B;
			else
				next_state = A;
		end
		default: next_state = A;
	endcase
end

// output assignment
always @(state, w) begin
	if (state == B) begin
		if (w)
			z = 1'b1;
		else
			z = 1'b0;
	end else begin
		z = 1'b0;
	end
end

endmodule
