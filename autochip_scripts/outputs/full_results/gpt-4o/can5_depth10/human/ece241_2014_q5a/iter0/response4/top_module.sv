module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
    reg state, next_state;
    reg carry;

    // State encoding
    parameter S0 = 1'b0, S1 = 1'b1;

    // Moore state machine: state transition
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S0; // Reset state
			carry <= 1'b1; // Carry initiates as 1 for 2's complement computation
		end else begin
			state <= next_state;
		end
	end

    // Next state logic
	always @(*) begin
		case (state)
			S0: next_state = S0;
			S1: next_state = S1;
			default: next_state = S0;
		endcase
	end

    // Output logic and state transition
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			z <= 1'b0;
		end else begin
			case (state)
				S0: begin
					if (carry) begin
						z <= ~x; // Complement the input bit
						carry <= x ? 1'b0 : 1'b1; // Update carry for future bits
					end else begin
						z <= x; // Directly pass the input bit if carry is not active
						carry <= 1'b0;
					end
					state <= S1;
				end
				S1: begin
					if (carry) begin
						z <= ~x; // Complement the input bit further
						carry <= x ? 1'b0 : 1'b1; // Update carry for future bits
					end else begin
						z <= x; // Directly pass the input bit if carry is not active
						carry <= 1'b0;
					end
				end
				default: begin
					z <= 1'b0;
				end
			endcase
		end
	end
endmodule
