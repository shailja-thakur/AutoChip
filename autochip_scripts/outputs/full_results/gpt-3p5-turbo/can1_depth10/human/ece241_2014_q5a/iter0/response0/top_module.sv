module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [1:0] state;
	reg [1:0] next_state;
	reg z;

	always @(posedge clk or negedge areset) begin
		if (areset) begin
			state <= 2'b0;
		end else begin
			state <= next_state;
		end
	end

	always @(state, x) begin
		case (state)
			2'b00: begin
				if (x) begin
					next_state <= 2'b01;
				end else begin
					next_state <= 2'b00;
				end
				z <= x;
			end

			2'b01: begin
				next_state <= 2'b10;
				z <= ~x;
			end

			2'b10: begin
				next_state <= 2'b01;
				z <= x;
			end

			default: begin
				next_state <= 2'b00;
				z <= 0;
			end
		endcase
	end
endmodule
