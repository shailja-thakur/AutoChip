module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	reg [2:0] state;
	reg [7:0] data_byte;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;
		else begin
			case (state)
				3'b000: begin
					if (in == 1'b0)
						state <= 3'b001;
					else
						state <= 3'b000;
				end
				3'b001: begin
					data_byte <= 8'b00000000;
					state <= 3'b010;
				end
				3'b010: begin
					data_byte <= {data_byte[6:0], in};
					state <= 3'b011;
				end
				3'b011: begin
					if (in == 1'b1)
						state <= 3'b100;
					else
						state <= 3'b011;
				end
				3'b100: begin
					state <= 3'b101;
				end
				3'b101: begin
					out_byte <= data_byte;
					state <= 3'b000;
				end
				default: begin
					state <= 3'b000;
				end
			endcase
		end
	end
	
	assign done = (state == 3'b101);

endmodule
