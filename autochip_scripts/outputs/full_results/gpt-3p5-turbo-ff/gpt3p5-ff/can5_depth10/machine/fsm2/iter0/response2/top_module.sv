module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	
	reg [1:0] state, next_state;
	
	always @ (posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00;
		end else begin
			state <= next_state;
		end
	end
	
	always @ (*) begin
		case (state)
			0: begin
				if (j) begin
					next_state = 2'b01;
				end else begin
					next_state = 2'b00;
				end
			end
			
			1: begin
				if (k) begin
					next_state = 2'b00;
				end else begin
					next_state = 2'b01;
				end
			end
		endcase
	end
	
	assign out = (state == 1'b1) ? 1'b1 : 1'b0;
	
endmodule
