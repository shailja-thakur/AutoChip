module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [3:0] state;
	assign start_shifting = (state == 3'b111);

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;
		else begin
			case (state)
				3'b000:
					if (data)
						state <= 3'b001;
					else
						state <= 3'b000;
				3'b001:
					if (data)
						state <= 3'b011;
					else
						state <= 3'b000;
				3'b011:
					if (data)
						state <= 3'b011;
					else
						state <= 3'b110;
				3'b110:
					if (data)
						state <= 3'b111;
					else
						state <= 3'b000;
				3'b111:
					state <= 3'b111;
			endcase
		end
	end
endmodule
