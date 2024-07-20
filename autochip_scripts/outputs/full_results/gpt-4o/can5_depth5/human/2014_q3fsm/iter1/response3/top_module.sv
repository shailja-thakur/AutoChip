module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		A = 2'b00,
		B = 2'b01,
		C1 = 2'b10
	} state_t;
	
	// State and counter declaration
	state_t state, next_state;
	reg [1:0] w_count;
	reg [2:0] cycle_counter; 

	// State transition
	always_ff @(posedge clk) begin
		if (reset) begin
			state <= A;
			w_count <= 2'b00;
			cycle_counter <= 3'b000;
			z <= 1'b0;
		end
		else begin
			state <= next_state;
			if (state == B) begin
				if (cycle_counter == 3'b100) begin
					if (w_count == 2'b10) 
						z <= 1'b1;
					else
						z <= 1'b0;
					w_count <= 2'b00;
					cycle_counter <= 3'b000;
				end
				else begin
					if (w)
						w_count <= w_count + 1;
					cycle_counter <= cycle_counter + 1;
				end
			end
			else begin
				z <= 1'b0;
			end
		end
	end

	// Next state logic
	always_comb begin
		next_state = state;
		case(state)
			A: begin
				if (s == 1'b1) begin
					next_state = B;
				end
			end
			B: begin
				if (cycle_counter == 3'b100) begin
					next_state = B;
				end
			end
			default: next_state = A;
		endcase
	end

endmodule
