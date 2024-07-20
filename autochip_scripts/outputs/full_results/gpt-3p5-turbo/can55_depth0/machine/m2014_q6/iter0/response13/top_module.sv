module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

// State enumeration
typedef enum logic [2:0] {
	A,
	B,
	C,
	D,
	E,
	F
} state_type;

// State registers
reg state_type current_state;
reg state_type next_state;

always @(posedge clk) begin
	if (reset == 1) begin
		current_state <= A;
	end
	else begin
		current_state <= next_state;
	end
end

always @(*) begin
	case (current_state)
		A: begin
			next_state = (w == 0) ? B : A;
		end
		B: begin
			next_state = (w == 1) ? C : D;
		end
		C: begin
			next_state = (w == 0) ? E : D;
		end
		D: begin
			next_state = (w == 1) ? A : F;
		end
		E: begin
			next_state = (w == 0) ? E : D;
		end
		F: begin
			next_state = (w == 1) ? C : D;
		end
	endcase
end

// Output logic
always @(current_state) begin
	z = (current_state == E || current_state == F) ? 1 : 0;
end

endmodule
