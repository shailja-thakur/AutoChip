module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [3:0] state;
	reg start_shifting;
	reg [3:0] seq_cnt;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 4'b0000;
		else begin
			case(state)
				4'b0000: begin
					if (data) begin
						state <= 4'b0001;
						seq_cnt <= 4'b0000;
					end else
						state <= 4'b0000;
				end

				4'b0001: begin
					if (data) begin
						state <= 4'b0010;
						seq_cnt <= 4'b0000;
					end else begin
						state <= 4'b0000;
						seq_cnt <= 4'b0000;
					end
				end

				4'b0010: begin
					if (data) begin
						state <= 4'b0011;
						seq_cnt <= 4'b0000;
					end else
						state <= 4'b0000;
				end

				4'b0011: begin
					if (data) begin
						state <= 4'b0100;
						seq_cnt <= 4'b0000;
					end else
						state <= 4'b0000;
				end

				4'b0100: begin
					if (data) begin
						state <= 4'b0001;
						seq_cnt <= seq_cnt + 1;
					end else
						state <= 4'b0000;
				end
			endcase
		end
	end

	assign start_shifting = (seq_cnt == 4'b1101);

endmodule
