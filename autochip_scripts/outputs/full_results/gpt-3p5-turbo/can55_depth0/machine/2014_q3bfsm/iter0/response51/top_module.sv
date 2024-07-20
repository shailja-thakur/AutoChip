module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= 3'b000; // Initial state is A
		z <= 1'b0;
	end else begin
		state <= next_state;
		if (state == 3'b011 || state == 3'b100) begin
			z <= 1'b1; // Output is high when state is D or E
		end else begin
			z <= 1'b0;
		end
	end
end

always @(state, x) begin
	case(state)
		3'b000: begin
			if (x) begin // If state is A and x is high, next state is B
				next_state = 3'b001;
			end else begin // If state is A and x is low, next state is A
				next_state = 3'b000;
			end
		end
		3'b001: begin
			if (x) begin // If state is B and x is high, next state is E
				next_state = 3'b100;
			end else begin // If state is B and x is low, next state is B
				next_state = 3'b001;
			end
		end
		3'b010: begin
			if (x) begin // If state is C and x is high, next state is B
				next_state = 3'b001;
			end else begin // If state is C and x is low, next state is C
				next_state = 3'b010;
			end
		end
		3'b011: begin
			if (x) begin // If state is D and x is high, next state is C
				next_state = 3'b010;
			end else begin // If state is D and x is low, next state is B
				next_state = 3'b001;
			end
		end
		3'b100: begin
			if (x) begin // If state is E and x is high, next state is E
				next_state = 3'b100;
			end else begin // If state is E and x is low, next state is D
				next_state = 3'b011;
			end
		end
		default: next_state = 3'b000; // Default state is A
	endcase
end

endmodule
