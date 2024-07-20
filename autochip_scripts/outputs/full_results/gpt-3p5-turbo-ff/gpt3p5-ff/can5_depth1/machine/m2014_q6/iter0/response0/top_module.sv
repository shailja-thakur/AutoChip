module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

// State enum
typedef enum {
	A,
	B,
	C,
	D,
	E,
	F
} state_type;

// Registers
reg [2:0] state;
reg [2:0] next_state;

// State transitions
always @(posedge clk) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

// Next state logic
always @(*) begin
	case (state)
		A: begin
			if (w == 0) begin
				next_state = B;
			end else begin
				next_state = A;
			end
		end
		
		B: begin
			if (w == 1) begin
				next_state = D;
			end else begin
				next_state = C;
			end
		end
		
		C: begin
			if (w == 1) begin
				next_state = D;
			end else begin
				next_state = E;
			end
		end
		
		D: begin
			if (w == 1) begin
				next_state = A;
			end else begin
				next_state = F;
			end
		end
		
		E: begin
			if (w == 1) begin
				next_state = D;
			end else begin
				next_state = E;
			end
		end
		
		F: begin
			if (w == 1) begin
				next_state = D;
			end else begin
				next_state = C;
			end
		end
	endcase
end

// Output assignment
always @(state) begin
	if (state == E || state == F) begin
		z = 1'b1;
	end else begin
		z = 1'b0;
	end
end

endmodule
