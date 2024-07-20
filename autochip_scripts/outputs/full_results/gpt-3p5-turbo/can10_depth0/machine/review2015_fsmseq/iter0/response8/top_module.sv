module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [3:0] state;
	assign start_shifting = (state == 4'b0111);

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 4'b0000;
		else
		begin
			case (state)
				4'b0000: state <= (data) ? 4'b0001 : 4'b0000;
				4'b0001: state <= (data) ? 4'b0011 : 4'b0000;
				4'b0011: state <= (data) ? 4'b0011 : 4'b0110;
				4'b0110: state <= (data) ? 4'b0111 : 4'b0000;
				4'b0111: state <= 4'b0111;
			endcase
		end
	end

endmodule
