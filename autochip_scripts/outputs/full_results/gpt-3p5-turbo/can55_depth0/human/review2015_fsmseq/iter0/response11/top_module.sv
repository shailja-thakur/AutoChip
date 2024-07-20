module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

	reg [3:0] state;
	reg found_sequence;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			found_sequence <= 0;
			start_shifting <= 0;
		end
		else begin
			case(state)
				0: if (data) state <= 1;
				1: if (data) state <= 2; else state <= 0;
				2: if (data) state <= 3; else state <= 0;
				3: if (data) begin
						state <= 4;
						found_sequence <= 1;
					end
					else state <= 0;
				4: begin
						found_sequence <= 1;
						start_shifting <= 1;
					end
			endcase
		end
	end

endmodule
