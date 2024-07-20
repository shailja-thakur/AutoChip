module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	reg [1:0] state;
	initial begin
		state = 2'b00;
	end

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else begin
			case (state)
				2'b00: begin
					if (j)
						state <= 2'b01;
				end
				2'b01: begin
					if (k)
						state <= 2'b00;
				end
			endcase
		end
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
