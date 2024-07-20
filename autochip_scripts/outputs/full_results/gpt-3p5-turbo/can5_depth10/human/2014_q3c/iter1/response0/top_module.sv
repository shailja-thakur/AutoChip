module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	reg [2:0] next_state;
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			next_state <= 3'b000;
		end else begin
			case ({x, y})
				3'b000: next_state <= 3'b000;
				3'b001: next_state <= 3'b100;
				3'b010: next_state <= 3'b001;
				3'b011: next_state <= 3'b010;
				3'b100: next_state <= 3'b100;
			endcase
		end
	end

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			Y0 <= 1'b0;
			z <= 1'b0;
		end else begin
			case (next_state)
				3'b000: begin
					Y0 <= 1'b0;
					z <= 1'b0;
				end
				3'b001: begin
					Y0 <= 1'b1;
					z <= 1'b0;
				end
				3'b010: begin
					Y0 <= 1'b0;
					z <= 1'b0;
				end
				3'b011: begin
					Y0 <= 1'b0;
					z <= 1'b1;
				end
				3'b100: begin
					Y0 <= 1'b1;
					z <= 1'b1;
				end
			endcase
		end
	end
endmodule
