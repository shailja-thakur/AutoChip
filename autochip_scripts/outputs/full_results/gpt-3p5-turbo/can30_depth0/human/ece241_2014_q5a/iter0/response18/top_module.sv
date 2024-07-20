module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	// Define states
	typedef enum logic [1:0] {WAIT, CONVERT} state;

	// Registers
	reg [1:0] current_state, next_state;
	reg signed [31:0] count;
	reg signed [31:0] sum;

	// Output wire
	wire signed [31:0] complement;

	// Moore state machine
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= WAIT;
		else
			current_state <= next_state;
	end

	always_comb begin
		// Assign next_state based on current_state and inputs
		case (current_state)
			WAIT: if (!areset) begin
					if (x != 1'b0)
						next_state = CONVERT;
					else
						next_state = WAIT;
				end
				else
					next_state = WAIT;
			CONVERT: if (!areset) begin
					if (count == 0)
						next_state = WAIT;
					else
						next_state = CONVERT;
				end
				else
					next_state = WAIT;
			default: next_state = WAIT;
		endcase
	end

	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			count <= 32'd0;
			sum <= 32'd0;
		end
		else begin
			case (current_state)
				CONVERT: begin
						sum <= sum + (x << count);
						count <= count + 1;
					end
			endcase
		end
	end

	always_comb begin
		complement = -sum;
	end

	assign z = complement;

endmodule
