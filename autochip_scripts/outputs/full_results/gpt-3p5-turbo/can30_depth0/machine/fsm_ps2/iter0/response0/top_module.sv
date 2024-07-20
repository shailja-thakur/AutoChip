module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [7:0] state;
wire third_bit;

assign third_bit = in[2];

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 4'h1;
	else begin
		case (state)
			4'h1: begin
				if (third_bit)
					state <= 4'h2;
				else
					state <= 4'h1;
			end
			4'h2: state <= 4'h3;
			4'h3: state <= 4'h4;
			4'h4: begin
				if (third_bit)
					state <= 4'h2;
				else
					state <= 4'h1;
			end
		endcase
	end
end

assign done = (state == 4'h4);

endmodule
