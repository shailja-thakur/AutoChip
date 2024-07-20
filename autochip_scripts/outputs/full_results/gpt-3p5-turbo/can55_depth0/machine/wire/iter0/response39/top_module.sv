module top_module(
	input wire clk,
	input wire reset,
	output wire data_output,
	output wire valid_output);

	reg [1:0] state;
	reg [3:0] counter;
	reg [7:0] data;
	wire clk_edge;
	
	assign clk_edge = clk & ~previous_clk;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;
			counter <= 4'b0000;
		end else begin
			case (state)
				2'b00: begin // idle state
					counter <= 4'b0000;
					data <= 8'b00000000;
					state <= 2'b01;
				end
				2'b01: begin // wait state
					if (counter < 4'b1111) begin
						counter <= counter + 1;
						data <= 8'b00000000;
					end else begin
						counter <= 4'b0000;
						state <= 2'b10;
					end
				end
				2'b10: begin // process state
					data <= in;
					state <= 2'b11;
				end
				2'b11: begin // done state
					data <= in;
					valid_output <= 1'b1;
					state <= 2'b00;
				end
				default: state <= 2'b00; //default state
			endcase
		end
	end

	always @(posedge clk) begin
		previous_clk <= clk;
	end
	
	assign out = data_output;

endmodule
