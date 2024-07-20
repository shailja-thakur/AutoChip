module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

	reg [3:0] state;
	reg [2:0] counter;
	reg [6:0] rx_data;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
			counter <= 3'b000;
			rx_data <= 7'b0;
		end else begin
			case (state)
				4'b0000: begin
					if (in == 1'b0) begin
						state <= 4'b0001;
						counter <= 3'b000;
						rx_data <= 7'b0;
					end
				end
				4'b0001: begin
					state <= 4'b0010;
					counter <= 3'b000;
					rx_data <= in;
				end
				4'b0010: begin
					if (counter == 3'b111) begin
						state <= 4'b0011;
						counter <= 3'b000;
						rx_data <= in;
					end else begin
						counter <= counter + 1;
						rx_data <= {rx_data[5:0], in};
					end
				end
				4'b0011: begin
					state <= 4'b0000;
					counter <= 3'b000;
					rx_data <= 7'b0;
					if (in == 1'b1) begin
						out_byte <= rx_data;
						done <= 1'b1;
					end else begin
						done <= 1'b0;
					end
				end
				default: state <= 4'b0000;
			endcase
		end
	end

endmodule
