module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [1:0] state = 2'b00;
	reg next_state;
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00;
		end else begin
			state <= next_state;
		end
	end

	always @* begin
		case (state)
			2'b00: begin // State A
				if (x) begin
					next_state = 2'b01;
					z = 1'b1;
				end else begin
					next_state = 2'b00;
					z = 1'b0;
				end
			end
			2'b01: begin // State B
				if (x) begin
					next_state = 2'b00;
					z = 1'b0;
				end else begin
					next_state = 2'b01;
					z = 1'b1;
				end
			end
			default: begin
				next_state = 2'b00;
				z = 1'b0;
			end
		endcase
	end

endmodule
