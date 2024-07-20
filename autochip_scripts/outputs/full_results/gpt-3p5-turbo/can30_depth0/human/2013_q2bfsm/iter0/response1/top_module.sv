module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg f;
reg g;
reg [1:0] state;
reg [2:0] counter;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= 2'b00;
		f <= 0;
		g <= 0;
		counter <= 0;
	end else begin
		case (state)
			2'b00: begin
				f <= 1;
				state <= 2'b01;
				counter <= 0;
			end

			2'b01: begin
				if (counter == 2'b001 && x == 1 && y == 0 && x == 1) begin
					state <= 2'b10;
					counter <= 0;
				end else begin
					counter <= counter + 1;
				end
			end

			2'b10: begin
				if (y == 1) begin
					g <= 1;
				end
				state <= 2'b11;
			end
			
			2'b11: begin
				if (y == 1 && counter < 2'b10) begin
					state <= 2'b11;
					counter <= 0;
				end else begin
					g <= 0;
					state <= 2'b00;
				end
			end
		endcase
	end
end
endmodule
