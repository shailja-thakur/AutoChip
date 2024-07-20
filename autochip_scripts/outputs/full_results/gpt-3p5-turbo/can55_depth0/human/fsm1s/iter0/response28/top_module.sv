module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	wire new_state;

	// State machine logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b01; // B state
		end else begin
			state <= new_state;
		end
	end

	// State transition logic
	always @* begin
		case (state)
			2'd0: begin
				if (in)
					new_state = 2'b00; // A state
				else
					new_state = 2'b01; // B state
			end
			
			2'd1: begin
				if (in)
					new_state = 2'b01; // B state
				else
					new_state = 2'b00; // A state
			end
		endcase
	end

	// Output assignment
	assign out = (state == 2'b00) ? 1'b0 : 1'b1;

endmodule
