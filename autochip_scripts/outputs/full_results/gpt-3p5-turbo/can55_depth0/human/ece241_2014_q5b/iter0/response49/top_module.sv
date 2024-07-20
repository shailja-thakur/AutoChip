module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	reg [1:0] state, next_state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00; // State A
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or x) begin
		case (state)
			2'b00: begin // State A
				if (x) begin
					next_state = 2'b01; // Next state B
				end else begin
					next_state = 2'b00; // Next state A
				end
				z = 1'b0;
			end
			
			2'b01: begin // State B
				if (x) begin
					next_state = 2'b00; // Next state A
				end else begin
					next_state = 2'b01; // Next state B
				end
				z = 1'b1;
			end
			
			default: begin
				next_state = 2'b00; // Default state A
				z = 1'b0;
			end
		endcase
	end
	
endmodule
