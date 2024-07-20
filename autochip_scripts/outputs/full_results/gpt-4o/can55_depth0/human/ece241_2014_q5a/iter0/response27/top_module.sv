module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State declaration
	typedef enum reg [1:0] {
		IDLE = 2'b00,
		COMPLEMENT = 2'b01,
		FINISH = 2'b10
	} state_t;

	state_t state, next_state;
	reg carry, next_carry;

	// State transition
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= IDLE;
			carry <= 0;
		end else begin
			state <= next_state;
			carry <= next_carry;
		end
	end

	// Next state and output logic
	always @(*) begin
		z = 0;
		next_state = state;
		next_carry = carry;

		case (state)
			IDLE: begin
				if (!areset) begin
					next_state = COMPLEMENT;
					next_carry = 1; // Start with carry as 1 for 2's complement
				end
			end
			COMPLEMENT: begin
				z = carry ^ x; // XOR for bit-wise inversion
				next_carry = carry & x; // AND to keep track of carry for next bit
				if (areset) begin
					next_state = IDLE;
					next_carry = 0;
				end
			end
			default: begin
				next_state = IDLE; // Default to IDLE in case of unknown state
				next_carry = 0;
			end
		endcase
	end
endmodule
