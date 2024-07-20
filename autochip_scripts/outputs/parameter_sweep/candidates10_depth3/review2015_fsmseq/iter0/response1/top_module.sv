module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	parameter S3 = 2'b11;

	reg [1:0] state;
	reg [3:0] shift_register;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else begin
			case (state)
				S0: begin
					if (data)
						shift_register <= {shift_register[2:0], data};
					state <= S1;
				end
				S1: begin
					if (data)
						shift_register <= {shift_register[2:0], data};
					else
						state <= S0;
				end
				S2: begin
					if (data)
						shift_register <= {shift_register[2:0], data};
					else
						state <= S0;
				end
				S3: begin
					if (data)
						shift_register <= {shift_register[2:0], data};
					else
						start_shifting <= 1;
				end
			endcase
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset)
			start_shifting <= 0;
		else
			start_shifting <= 0;
	end
endmodule
