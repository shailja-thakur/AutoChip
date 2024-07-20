module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [3:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 4'b0000;
		else begin
			case (state)
				4'b0000: begin // State 0
					if (data)
						state <= 4'b0001;
				end
				4'b0001: begin // State 1
					if (data)
						state <= 4'b0011;
					else
						state <= 4'b0000;
				end
				4'b0011: begin // State 2
					if (data)
						state <= 4'b0111;
					else
						state <= 4'b0000;
				end
				4'b0111: begin // State 3
					if (data)
						state <= 4'b1111;
					else
						state <= 4'b0000;
				end
				4'b1111: begin // State 4
					state <= 4'b0000;
				end
			endcase
		end
	end

	assign start_shifting = (state == 4'b1111);

endmodule
