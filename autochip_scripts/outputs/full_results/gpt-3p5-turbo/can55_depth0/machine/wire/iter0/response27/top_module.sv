module top_module(
	input wire clk,
	input wire rst,
	output reg [7:0] data_out,
	output reg valid_out);

	reg [1:0] state;
	reg [7:0] counter;

	always @(posedge clk or posedge rst) begin
		if (rst)
			state <= 2'b00;
		else
			state <= next_state;
	end

	always @(posedge clk) begin
		case(state)
			2'b00: begin // idle state
				counter <= 8'b00000000;
				data_out <= 8'b00000000;
				valid_out <= 1'b0;
				if (rst)
					state <= 2'b00;
				else
					state <= 2'b01;
			end
			
			2'b01: begin // wait state
				counter <= counter + 1;
				data_out <= 8'b00000000;
				valid_out <= 1'b0;
				if (counter >= 8'b00000011)
					state <= 2'b10;
			end
			
			2'b10: begin // process state
				data_out <= in;
				state <= 2'b11;
			end
			
			2'b11: begin // done state
				data_out <= in;
				valid_out <= 1'b1;
				state <= 2'b00;
			end
		endcase
	end
endmodule
