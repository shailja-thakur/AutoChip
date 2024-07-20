module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [2:0] state;
	reg start_shifting;

	always@(posedge clk or posedge reset) begin
		if(reset)
			state <= 0;
		else begin
			case(state)
				0: begin
					if(data)
						state <= 1;
					else
						state <= 0;
				end
				1: begin
					if(data)
						state <= 2;
					else
						state <= 0;
				end
				2: begin
					if(data)
						state <= 3;
					else
						state <= 0;
				end
				3: begin
					if(data)
						start_shifting <= 1;
					
					state <= 4;
				end
				default: state <= 0;
			endcase
		end
	end

endmodule
