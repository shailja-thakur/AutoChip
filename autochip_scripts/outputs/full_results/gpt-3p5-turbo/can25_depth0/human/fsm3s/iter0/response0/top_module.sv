module top_module (
	input clk,
	input in,
	input reset,
	output out
);

// State register
reg [1:0] state_reg;
// Next State outputs
reg [1:0] next_state_zero;
reg [1:0] next_state_one;

// Output register
reg out_reg;

// Define states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define next states for each input
always_comb begin
	case(state_reg)
		A: begin
			next_state_zero = A;
			next_state_one = B;
		end
		B: begin
			next_state_zero = C;
			next_state_one = B;
		end
		C: begin
			next_state_zero = A;
			next_state_one = D;
		end
		D: begin
			next_state_zero = C;
			next_state_one = B;
		end
	endcase
end

// Define outputs for each state
always_comb begin
	case(state_reg)
		A: out_reg = 1'b0;
		B: out_reg = 1'b0;
		C: out_reg = 1'b0;
		D: out_reg = 1'b1;
	endcase
end

// State transition and output assignment
always_ff @(posedge clk) begin
	if (reset) begin
		state_reg <= A;
	end else begin
		if (in) begin
			state_reg <= next_state_one;
		end else begin
			state_reg <= next_state_zero;
		end
	end
	
	out <= out_reg;
end

endmodule
