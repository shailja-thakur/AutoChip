module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	reg [2:0] next_state;

	always @(posedge clk) begin
		case ({x, y})
			2'b00_000: next_state <= 3'b00_000;
			2'b10_000: next_state <= 3'b00_001;
			2'b01_000: next_state <= 3'b00_100;
			2'b11_000: next_state <= 3'b00_010;
			2'b10_001: next_state <= 3'b01_001;
			2'b01_010: next_state <= 3'b01_001;
			2'b11_011: next_state <= 3'b01_010;
			2'b00_100: next_state <= 3'b11_100;
		endcase
	end

	always @(posedge clk) begin
		case ({x, y})
			2'b00_000: begin
				Y0 <= 1'b0;
				z <= 1'b0;
			end
			2'b10_000: begin
				Y0 <= next_state[0];
				z <= 1'b0;
			end
			2'b01_000: begin
				Y0 <= next_state[0];
				z <= 1'b0;
			end
			2'b11_000: begin
				Y0 <= next_state[0];
				z <= 1'b1;
			end
			2'b10_001: begin
				Y0 <= next_state[0];
				z <= 1'b1;
			end
			2'b01_010: begin
				Y0 <= next_state[0];
				z <= 1'b0;
			end
			2'b11_011: begin
				Y0 <= next_state[0];
				z <= 1'b1;
			end
			2'b00_100: begin
				Y0 <= next_state[0];
				z <= 1'b1;
			end
		endcase
	end

endmodule
