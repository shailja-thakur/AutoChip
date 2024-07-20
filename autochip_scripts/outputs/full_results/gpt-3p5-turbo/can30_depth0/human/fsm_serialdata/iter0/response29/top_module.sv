module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	reg [3:0] state;
	reg [7:0] data;
	wire start;
	wire stop;

	assign start = (state == 0) && (in == 0);
	assign stop = (state == 9) && (in == 1);

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else begin
			case (state)
				0: if (start)
						state <= 1;
					else
						state <= 0;
				1: begin
						data <= in;
						state <= 2;
					end
				2 to 8: begin
						data <= {data[6:0], in};
						state <= state + 1;
					end
				9: if (stop) begin
						out_byte <= data;
						state <= 0;
					end
					else
						state <= 9;
			endcase
		end
	end

	assign done = (state == 9);
endmodule
