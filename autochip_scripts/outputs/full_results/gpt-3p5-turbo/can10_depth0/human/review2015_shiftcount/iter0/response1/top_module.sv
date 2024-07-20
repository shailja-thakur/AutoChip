module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);
	
	parameter COUNT_DELAY = 4'b0100;
	
	reg [3:0] shift_reg;
	reg [1:0] counter;
	parameter [1:0] COUNT_IDLE = 2'b00;
	
	always @(posedge clk) begin
		if(shift_ena) begin
			shift_reg <= {data, shift_reg[3:1]};
		end
		if(count_ena) begin
			case(counter)
				2'b00: counter <= COUNT_IDLE;
				2'b01: counter <= COUNT_DELAY;
				2'b10: counter <= COUNT_IDLE;
				2'b11: counter <= COUNT_IDLE;
			endcase
			if(counter == COUNT_IDLE) begin
				if(shift_ena) begin
					shift_reg <= {data, shift_reg[3:1]};
				end
				counter <= COUNT_DELAY;
			end else begin
				counter <= counter + 1'b1;
			end
		end else begin
			counter <= COUNT_IDLE;
		end
	end
	
	assign q = shift_reg;
	
endmodule
