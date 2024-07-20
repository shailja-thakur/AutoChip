module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00;
		end else begin
			case (state)
				2'b00: begin
					if (x)
						state <= 2'b01;
					else
						state <= 2'b00;
				end
				2'b01: begin
					if (x)
						state <= 2'b00;
					else
						state <= 2'b01;
				end
				default: begin
					state <= 2'b00;
				end
			endcase
		end
	end
	
	assign z = (state == 2'b10) ? 1'b1 : 1'b0;
    
endmodule
