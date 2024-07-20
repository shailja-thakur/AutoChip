module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [1:0] state;
	always @(posedge clk or posedge reset)
	begin
		if(reset)
			state <= 2'b00;
		else
		begin
			case(state)
				2'b00:
					if(data)
						state <= 2'b01;
					else
						state <= 2'b00;
				2'b01:
					if(data)
						state <= 2'b10;
					else
						state <= 2'b00;
				2'b10:
					if(data)
						state <= 2'b10;
					else
						state <= 2'b11;
				2'b11:
					if(data)
						state <= 2'b11;
					else
						state <= 2'b01;
			endcase
		end
	end
	
	assign start_shifting = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
