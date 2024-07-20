module top_module (
	input clk,
	input in,
	input reset,
	output out
);

// define states
parameter B = 1'b0;
parameter A = 1'b1;

// define registers and wires
reg state; // current state register
wire next_state; // next state wire

// define output reg
reg out_reg; // output register

// assign next state logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= B;
	end
	else begin
		state <= next_state;
	end
end

// assign next state logic based on current state and input
always @(state or in) begin
	case(state)
		B: begin
			if (in == 0)
				next_state = A;
			else
				next_state = B;
		end
		A: begin
			if (in == 0)
				next_state = B;
			else
				next_state = A;
		end
	endcase
end

// assign output based on current state
always @(state) begin
	case(state)
		B: out_reg = 1'b1;
		A: out_reg = 1'b0;
	endcase
end

// assign output to module output
assign out = out_reg;

endmodule
