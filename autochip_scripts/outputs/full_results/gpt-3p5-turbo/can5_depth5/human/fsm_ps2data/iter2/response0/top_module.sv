module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [7:0] prev_in = 8'h00;
reg [7:0] prev_prev_in = 8'h00;
reg [23:0] message;
reg [2:0] state = 0;
reg [23:0] out_bytes_reg;
reg done_reg;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		message <= 0;
		out_bytes_reg <= 0;
		done_reg <= 0;
		prev_in <= 8'h00;
		prev_prev_in <= 8'h00;
	end else begin
		prev_prev_in <= prev_in;
		prev_in <= in;
		if (state == 0) begin
			if (in[3] == 1) begin
				state <= 1;
			end
		end else if (state == 1) begin
			if (in[3] == 1) begin
				state <= 2;
			end else begin
				state <= 0;
			end
		end else if (state == 2) begin
			if (in[3] == 1) begin
				message <= {prev_prev_in, prev_in, in};
				state <= 3;
			end else begin
				state <= 0;
			end
		end else if (state == 3) begin
			if (in[3] == 1) begin
				state <= 2;
			end else begin
				state <= 0;
			end
		end
	end
end

always @(posedge clk) begin
	if (state == 3) begin
		out_bytes_reg <= message;
		done_reg <= 1;
	end else begin
		out_bytes_reg <= 24'hzzzzzz;
		done_reg <= 0;
	end
end

assign done = done_reg;
assign out_bytes = out_bytes_reg;

endmodule
