module top_module(
	input wire clk,
	input wire rst,
	output wire data_output,
	output wire valid_output);

reg [1:0] state;
reg [2:0] counter;
reg [7:0] data_output_reg;
reg valid_output_reg;

always @(posedge clk) begin
	if (rst) begin
		state <= 2'b00;
		counter <= 3'b000;
		data_output_reg <= 8'b00000000;
		valid_output_reg <= 1'b0;
	else begin
		case(state)
			2'b00: begin // idle state
				counter <= 3'b000;
				data_output_reg <= 8'b00000000;
				valid_output_reg <= 1'b0;
				
				if (rst)
					state <= 2'b00;
				else
					state <= 2'b01;
			end
			2'b01: begin // wait state
				counter <= counter + 1;
				data_output_reg <= 8'b00000000;
				valid_output_reg <= 1'b0;
				
				if (counter == 3'b100) // threshold value
					state <= 2'b10;
				else
					state <= 2'b01;
			end
			2'b10: begin // process state
				data_output_reg <= in;
				valid_output_reg <= 1'b0;
				state <= 2'b11;
			end
			2'b11: begin // done state
				data_output_reg <= in;
				valid_output_reg <= 1'b1;
				state <= 2'b00;
			end
		endcase
	end
end

assign data_output = data_output_reg;
assign valid_output = valid_output_reg;

endmodule
