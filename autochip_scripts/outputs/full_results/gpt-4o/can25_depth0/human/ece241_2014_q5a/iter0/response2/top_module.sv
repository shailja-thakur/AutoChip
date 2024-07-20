module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding
	typedef enum reg {IDLE, COMPLEMENT} state_t;
	state_t current_state, next_state;
	
	// Internal signal to keep track of inverting bits after first '1' is seen
	reg invert;

	// State transition on clock edge
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= IDLE;
			invert <= 1'b0;
		end else begin
			current_state <= next_state;
		end
	end

	// Next state logic and output logic
	always @(*) begin
		case (current_state)
			IDLE: begin
				if (invert == 1'b0 && x == 1'b1) begin
					invert = 1'b1;
					next_state = COMPLEMENT;
				end else begin
					next_state = IDLE;
				end
			end
			
			COMPLEMENT: begin
				next_state = COMPLEMENT;
			end
			
			default: begin
				next_state = IDLE;
			end
		endcase
	end

	// Output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			z <= 1'b0;
		end else begin
			if (invert) begin
				z <= ~x; // Invert the bit
			end else begin
				z <= x; // Pass the bit as it is
			end
		end
	end

endmodule
