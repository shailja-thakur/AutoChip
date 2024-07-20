module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg [1:0] state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00;
		end else begin
			case (state)
				2'b00: begin
					if (in) 
						state <= 2'b01;
					else 
						state <= 2'b00;
				end
				
				2'b01: begin
					if (in) 
						state <= 2'b01;
					else 
						state <= 2'b10;
				end
				
				2'b10: begin
					if (in) 
						state <= 2'b11;
					else 
						state <= 2'b00;
				end
				
				2'b11: begin
					if (in) 
						state <= 2'b01;
					else 
						state <= 2'b10;
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (state == 2'b11) begin
			out <= 1;
		end else begin
			out <= 0;
		end
	end

endmodule
