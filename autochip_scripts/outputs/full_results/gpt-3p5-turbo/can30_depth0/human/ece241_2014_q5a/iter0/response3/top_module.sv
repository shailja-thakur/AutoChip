module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	// State declaration
	reg [1:0] state;
	
	// Output declaration
	reg z;
	
	// Next state logic and output logic
	always @(posedge clk) begin
		if (areset == 1) begin
			state <= 2'b00;
			z <= 1'b0;
		end else begin
			case (state)
				2'b00: begin
					state <= 2'b01;
					z <= ~x;
				end
				2'b01: begin
					state <= 2'b10;
					z <= ~x;
				end
				2'b10: begin
					if (x == 1'b0)
						state <= 2'b10;
					else begin
						state <= 2'b11;
						z <= ~x;
					end
				end
				2'b11: begin
					state <= 2'b10;
					z <= ~x;
				end
			endcase
		end
	end

endmodule
