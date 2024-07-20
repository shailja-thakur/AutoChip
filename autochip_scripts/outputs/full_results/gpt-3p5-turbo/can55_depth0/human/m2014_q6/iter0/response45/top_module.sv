module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// Define states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
parameter E = 2'b100;
parameter F = 2'b101;

// Define flip-flops
reg [2:0] current_state, next_state;

// Next state logic
always @ (posedge clk, posedge reset) begin
	if (reset)
		current_state <= A;
	else
		current_state <= next_state;
end

// Output logic
always @ (current_state, w) begin
	case (current_state)
		A: if (w) next_state <= A; else next_state <= B;
		B: if (w) next_state <= D; else next_state <= C;
		C: if (w) next_state <= D; else next_state <= E;
		D: if (w) next_state <= A; else next_state <= F;
		E: if (w) next_state <= D; else next_state <= E;
		F: if (w) next_state <= D; else next_state <= C;
	endcase
end

// Output assignment
always @ (current_state) begin
	case (current_state)
		A: z = 1'b0;
		B: z = 1'b0;
		C: z = 1'b0;
		D: z = 1'b0;
		E: z = 1'b1;
		F: z = 1'b1;
	endcase
end

endmodule
