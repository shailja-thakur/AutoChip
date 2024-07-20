module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state, next_state;

	assign out = (state == 2'b11) ? 1'b1 : 1'b0;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;
		end else begin
			state <= next_state;
		end
	end

	always @(state or in) begin
		case (state)
			2'b00: begin
				if (in) begin
					next_state = 2'b01;
				end else begin
					next_state = 2'b00;
				end
			end
			2'b01: begin
				if (in) begin
					next_state = 2'b01;
				end else begin
					next_state = 2'b10;
				end
			end
			2'b10: begin
				if (in) begin
					next_state = 2'b11;
				end else begin
					next_state = 2'b00;
				end
			end
			2'b11: begin
				if (in) begin
					next_state = 2'b01;
				end else begin
					next_state = 2'b10;
				end
			end
			default: next_state = 2'b00;
		endcase
	end
endmodule
