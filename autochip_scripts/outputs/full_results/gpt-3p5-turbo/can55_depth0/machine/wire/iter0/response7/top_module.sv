module top_module(
	input wire clk,
	input wire reset,
	output wire data_out,
	output wire valid_out);
	
	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data_out;
	reg valid_out;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;
			counter <= 8'b0;
			data_out <= 8'b0;
			valid_out <= 1'b0;
		end else begin
			case(state)
				2'b00: begin // idle state
					counter <= 8'b0;
					data_out <= 8'b0;
					valid_out <= 1'b0;
					
					if (in) begin
						state <= 2'b01; // transition to wait state
					end
				end
				2'b01: begin // wait state
					counter <= counter + 1;
					data_out <= 8'b0;
					valid_out <= 1'b0;
					
					if (counter == 8'd10) begin
						state <= 2'b10; // transition to process state
					end
				end
				2'b10: begin // process state
					data_out <= in;
					state <= 2'b11; // transition to done state
				end
				2'b11: begin // done state
					valid_out <= 1'b1;
					state <= 2'b00; // transition back to idle state
				end
			endcase
		end
	end
	
	assign out = data_out;
endmodule
