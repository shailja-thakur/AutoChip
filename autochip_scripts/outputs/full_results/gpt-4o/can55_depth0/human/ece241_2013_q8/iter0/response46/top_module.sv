module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

// State encoding
typedef enum reg [1:0] {
	S0, // Initial state
	S1, // State after detecting '1'
	S2  // State after detecting '10'
} state_t;

state_t state, next_state;

// State transition
always @(posedge clk or negedge aresetn) begin
	if (!aresetn) begin
		state <= S0;
		z <= 0;
	end else begin
		state <= next_state;
	end
end

// Next state logic and output logic
always @(*) begin
	case (state)
		S0: begin
			if (x == 1) begin
				next_state <= S1;
				z <= 0;
			end else begin
				next_state <= S0;
				z <= 0;
			end
		end

		S1: begin
			if (x == 0) begin
				next_state <= S2;
				z <= 0;
			end else begin
				next_state <= S1;
				z <= 0;
			end
		end

		S2: begin
			if (x == 1) begin
				next_state <= S1;
				z <= 1;
			end else begin
				next_state <= S0;
				z <= 0;
			end
		end

		default: begin
			next_state <= S0;
			z <= 0;
		end
	endcase
end

endmodule
