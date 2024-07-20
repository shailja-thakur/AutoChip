module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	// Declare the states
	reg [1:0] state;
	
	// Define the outputs for each state
	assign out = (state == 2'b11) ? 1'b1 : 1'b0;
	
	// Define the state transition logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Asynchronous reset
			state <= 2'b00;
		end else begin
			case (state)
				2'b00: begin
					if (in) begin
						state <= 2'b01;
					end else begin
						state <= 2'b00;
					end
				end
				
				2'b01: begin
					if (in) begin
						state <= 2'b10;
					end else begin
						state <= 2'b01;
					end
				end
				
				2'b10: begin
					if (in) begin
						state <= 2'b11;
					end else begin
						state <= 2'b00;
					end
				end
				
				2'b11: begin
					if (in) begin
						state <= 2'b10;
					end else begin
						state <= 2'b01;
					end
				end
			endcase
		end
	end
endmodule
