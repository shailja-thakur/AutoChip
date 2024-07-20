module top_module (
	input clk,
	input reset,
	input [7:0] in,
	output reg [23:0] out_bytes,
	output reg done
);

	reg [2:0] state;
	reg [2:0] next_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			state <= next_state;
		end
	end

	always @(state or in) begin
		next_state = state;
		if (state == 3'b000) begin
			if (in[2] == 1)
				next_state = 3'b001;
		end else if (state == 3'b001) begin
			if (in[2] == 0)
				next_state = 3'b000;
			else
				next_state = 3'b010;
		end else if (state == 3'b010) begin
			if (in[2] == 0)
				next_state = 3'b000;
			else
				next_state = 3'b011;
		end else if (state == 3'b011) begin
			if (in[2] == 0)
				next_state = 3'b000;
			else
				next_state = 3'b011;
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			out_bytes <= 24'b0;
			done <= 0;
		end else begin
			out_bytes <= {out_bytes[15:0], in};
			if (state == 3'b011)
				done <= 1;
			else
				done <= 0;
		end
	end

endmodule
