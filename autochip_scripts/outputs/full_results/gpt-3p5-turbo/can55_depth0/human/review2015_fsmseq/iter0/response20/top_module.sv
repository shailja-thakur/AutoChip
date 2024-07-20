module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [3:0] state;
	reg start_shifting;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
			start_shifting <= 1'b0;
		end else begin
			case (state)
				4'b0000: begin
							if (data) state <= 4'b0001;
							else state <= 4'b0000;
						end
				4'b0001: begin
							if (data) state <= 4'b0010;
							else state <= 4'b0000;
						end
				4'b0010: begin
							if (data) state <= 4'b0011;
							else state <= 4'b0000;
						end
				4'b0011: begin
							if (data) begin
								state <= 4'b0000;
								start_shifting <= 1'b1;
							end else state <= 4'b0000;
						end
				default: state <= 4'b0000;
			endcase
		end
	end
endmodule
