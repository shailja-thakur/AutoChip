module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// State codes
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
parameter E = 2'b100;
parameter F = 2'b101;

// Registers
reg [1:0] state_reg;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
	if(reset)
		state_reg <= A;
	else
		state_reg <= next_state;
end

always @(state_reg or w) begin
	case(state_reg)
		A: begin
			if(w)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if(w)
				next_state = C;
			else
				next_state = D;
		end
		C: begin
			if(w)
				next_state = E;
			else
				next_state = D;
		end
		D: begin
			if(w)
				next_state = F;
			else
				next_state = A;
		end
		E: begin
			if(w)
				next_state = E;
			else
				next_state = D;
		end
		F: begin
			if(w)
				next_state = C;
			else
				next_state = D;
		end
	endcase
end

// FSM output
always @(state_reg) begin
	case(state_reg)
		A: z = 1'b0;
		B: z = 1'b0;
		C: z = 1'b0;
		D: z = 1'b0;
		E: z = 1'b1;
		F: z = 1'b1;
	endcase
end

endmodule
