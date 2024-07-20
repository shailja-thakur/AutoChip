module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	reg [1:0] state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b0;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or in) begin
		case (state)
			2'b00: begin // state A
				if (in) begin
					next_state = 2'b00;
				end else begin
					next_state = 2'b01;
				end
			end
			2'b01: begin // state B
				if (in) begin
					next_state = 2'b01;
				end else begin
					next_state = 2'b00;
				end
			end
		endcase
	end
	
	assign out = (state == 2'b01) ? 1'b1 : 1'b0;
	
endmodule
