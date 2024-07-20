module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// State definition
	reg [1:0] state;
	localparam INIT = 2'b00;
	localparam SHIFT = 2'b01;
	localparam DETECT = 2'b10;

	// Registers
	reg start_shifting_reg;

	always @(posedge clk)
	begin
		if (reset)
		begin
			state <= INIT;
			start_shifting_reg <= 0;
		end
		else
		begin
			case (state)
				INIT:
				begin
					if (data)
						state <= SHIFT;
				end

				SHIFT:
				begin
					if (data)
						state <= DETECT;
					else
						state <= INIT;
				end

				DETECT:
				begin
					if (data)
					begin
						state <= DETECT;
						start_shifting_reg <= 1;
					end
					else
					begin
						state <= INIT;
						start_shifting_reg <= 0;
					end
				end
			endcase
		end
	end

	assign start_shifting = start_shifting_reg;

endmodule
