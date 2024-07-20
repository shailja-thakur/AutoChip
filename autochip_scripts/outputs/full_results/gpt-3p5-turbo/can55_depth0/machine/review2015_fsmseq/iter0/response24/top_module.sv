module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [3:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 4'b0; // initial state S
		else begin
			case(state)
				4'b0000: begin // state S
					if (data)
						state <= 4'b0001; // next state S1
				end
				4'b0001: begin // state S1
					if (data)
						state <= 4'b0011; // next state S11
					else
						state <= 4'b0000; // next state S
				end
				4'b0011: begin // state S11
					if (data)
						state <= 4'b0011; // next state S11
					else
						state <= 4'b0110; // next state S110
				end
				4'b0110: begin // state S110
					if (data)
						state <= 4'b1111; // next state Done
					else
						state <= 4'b0000; // next state S
				end
				4'b1111: begin // state Done
					state <= 4'b1111; // next state Done
				end
			endcase
		end
	end

	assign start_shifting = (state == 4'b1111) ? 1'b1 : 1'b0;

endmodule
