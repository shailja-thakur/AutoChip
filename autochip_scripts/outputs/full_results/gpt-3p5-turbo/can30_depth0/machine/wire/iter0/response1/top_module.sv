module top_module(
	input wire clk,
	input wire reset,
	output wire data_out,
	output wire valid_out);

	// internal signals
	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data;

	// state definition
	localparam IDLE = 2'b00;
	localparam WAIT = 2'b01;
	localparam PROCESS = 2'b10;
	localparam DONE = 2'b11;

	// output assignment
	assign out = data_out;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			counter <= 8'b0;
			data_out <= 8'b0;
			valid_out <= 1'b0;
		end else begin
			case (state)
				IDLE: begin
					counter <= 8'b0;
					data_out <= 8'b0;
					valid_out <= 1'b0;
					if (in) begin
						state <= WAIT;
					end
				end
				WAIT: begin
					counter <= counter + 1;
					data_out <= 8'b0;
					valid_out <= 1'b0;
					if (counter >= 8'b10101010) begin
						state <= PROCESS;
					end
				end
				PROCESS: begin
					data_out <= data;
					state <= DONE;
				end
				DONE: begin
					valid_out <= 1'b1;
					state <= IDLE;
				end
			endcase
		end
	end
endmodule
