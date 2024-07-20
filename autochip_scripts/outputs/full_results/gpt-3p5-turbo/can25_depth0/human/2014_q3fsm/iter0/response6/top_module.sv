module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	
	// State declaration
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D,
		E
	} state_t;
	
	// State register and next state logic
	reg state_t current_state;
	reg state_t next_state;
	
	// Output register
	reg z;
	
	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Next state logic and output generation
	always @(*) begin
		case (current_state)
			A:
				if (s == 1) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			B:
				if (w == 1) begin
					next_state = C;
				end else begin
					next_state = B;
				end
			C:
				if (w == 1) begin
					next_state = D;
				end else begin
					next_state = C;
				end
			D:
				if (w == 1) begin
					next_state = E;
					z = 1;
				end else begin
					next_state = B;
					z = 0;
				end
			E:
				if (w == 1) begin
					next_state = E;
                end else begin
                	next_state = B;
                end
			default:
				next_state = A;
		endcase
	end

endmodule
