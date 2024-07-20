module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting
);

	reg [3:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
			start_shifting <= 0;
		end
		else begin
			case (state)
				4'b0000: if (data) state <= 4'b0001;
				4'b0001: if (data) state <= 4'b0010;
						  else state <= 4'b0000;
				4'b0010: if (data) state <= 4'b0011;
						  else state <= 4'b0000;
				4'b0011: if (data) begin
							  state <= 4'b0100;
							  start_shifting <= 1;
						  end
						  else state <= 4'b0000;
				4'b0100: if (data) state <= 4'b0100;
						  else state <= 4'b0000;
			endcase
		end
	end

endmodule
