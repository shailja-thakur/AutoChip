module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state;
	 
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00; // Reset to state A
		end else begin
			case(state)
				2'b00: begin // State A
					if (in) begin
						state <= 2'b01; // Next state B if in=1, else A
					end else begin
						state <= 2'b00; // Next state A if in=0
					end
				end
				2'b01: begin // State B
					if (in) begin
						state <= 2'b01; // Next state B if in=1
					end else begin
						state <= 2'b10; // Next state C if in=0
					end
				end
				2'b10: begin // State C
					if (in) begin
						state <= 2'b11; // Next state D if in=1
					end else begin
						state <= 2'b00; // Next state A if in=0
					end
				end
				2'b11: begin // State D
					if (in) begin
						state <= 2'b01; // Next state B if in=1
					end else begin
						state <= 2'b10; // Next state C if in=0
					end
				end
			endcase
		end
	end
	
	assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Set out to 1 when state is D

endmodule
