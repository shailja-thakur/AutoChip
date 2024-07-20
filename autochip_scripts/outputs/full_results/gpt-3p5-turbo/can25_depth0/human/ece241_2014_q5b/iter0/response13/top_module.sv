module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	reg [1:0] state, next_state;
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00; // Reset state A
		end else begin
			state <= next_state;
		end
	end

	always @* begin
		case (state)
			2'b00: begin // State A
				if (x) begin
					next_state = 2'b01; // Move to state B
					z = 1'b1; // Output z=1
				end else begin
					next_state = 2'b00; // Stay in state A
					z = 1'b0; // Output z=0
				end
			end

			2'b01: begin // State B
				if (x) begin
					next_state = 2'b01; // Stay in state B
					z = 1'b0; // Output z=0
				end else begin
					next_state = 2'b01; // Stay in state B
					z = 1'b1; // Output z=1
				end
			end

			default: begin
				next_state = 2'b00;
				z = 1'b0;
			end
		endcase
	end
endmodule
