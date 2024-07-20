module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b0;
		end else begin
			case (state)
				2'b00: begin
					if (x) begin
						state <= 2'b01;
					end
				end
				
				2'b01: begin
					if (~x) begin
						state <= 2'b01;
					end else begin
						state <= 2'b10;
					end
				end
				
				2'b10: begin
					if (x) begin
						state <= 2'b10;
					end else begin
						state <= 2'b01;
					end
				end
			endcase
		end
	end
	
	assign z = (state == 2'b00 || state == 2'b10) ? 1'b0 : 1'b1;
	
endmodule
