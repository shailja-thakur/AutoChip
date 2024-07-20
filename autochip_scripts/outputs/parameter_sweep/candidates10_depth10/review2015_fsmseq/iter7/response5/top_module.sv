module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting
);

	reg [2:0] state;
	reg [1:0] pattern;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
			pattern <= 2'b00;
		end else begin
			case (state)
				3'b000: begin
					if (data) begin
						state <= 3'b001;
					end else begin
						state <= 3'b000;
					end
				end
				3'b001: begin
					if (data) begin
						state <= 3'b010;
					end else begin
						state <= 3'b000;
					end
				end
				3'b010: begin
					if (data) begin
						state <= 3'b011;
					end else begin
						state <= 3'b000;
					end
				end
				3'b011: begin
					if (data) begin
						state <= 3'b001;
						pattern <= 2'b00;
						start_shifting <= 1;
					end else begin
						state <= 3'b000;
						pattern <= 2'b00;
					end
				end
			endcase
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			start_shifting <= 0;
		end
	end

endmodule
