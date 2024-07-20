module top_module(
	input clk,
	input rst,
	output reg data_out,
	output reg valid_out);

	reg [1:0] state;
	reg [7:0] counter;

	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;

	// Stimulus Generator module instance
	stimulus_gen stimulus_gen_inst(
		.clk(clk),
		.rst(rst)
	);

	// State machine logic
	always @(posedge clk or posedge rst) begin
		if (rst)
			state <= IDLE;
		else begin
			case (state)
				IDLE: begin
					counter <= 8'd0;
					data_out <= 8'd0;
					if (rst)
						state <= IDLE;
					else
						state <= WAIT;
				end
				WAIT: begin
					counter <= counter + 1;
					data_out <= 8'd0;
					if (counter >= 8'd10)
						state <= PROCESS;
					else
						state <= WAIT;
				end
				PROCESS: begin
					data_out <= in;
					state <= DONE;
				end
				DONE: begin
					valid_out <= 1'b1;
					state <= IDLE;
				end
				default: state <= IDLE;
			endcase
		end
	end

endmodule
module stimulus_gen(
	input clk,
	input rst
);
	// Your stimulus generator implementation goes here
	// ...
endmodule
