module top_module(
	input wire clk,
	input wire reset,
	output wire data_output,
	output wire valid_output);

	// Internal signals
	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data;

	// FSM states
	localparam IDLE = 2'b00;
	localparam WAIT = 2'b01;
	localparam PROCESS = 2'b10;
	localparam DONE = 2'b11;

	// Reset values
	initial begin
		state <= IDLE;
		counter <= 8'd0;
		data <= 8'd0;
	end

	always @(posedge clk) begin
		if (reset)
			state <= IDLE;
		else begin
			case (state)
				IDLE:
					begin
						counter <= 8'd0;
						data_output <= 8'd0;
						state <= WAIT;
					end
				WAIT:
					begin
						counter <= counter + 1;
						data_output <= 8'd0;
						if (counter >= 8'd10)
							state <= PROCESS;
					end
				PROCESS:
					begin
						data_output <= data;
						state <= DONE;
					end
				DONE:
					begin
						valid_output <= 1;
						state <= IDLE;
					end
				default:
					state <= IDLE;
			endcase
		end
	end

	// Testbench stimulus generator
	stimulus_gen stimulus_gen (
		.clk(clk),
		.reset(reset),
		.data(data)
	);
  
endmodule
module stimulus_gen(
	input wire clk,
	input wire reset,
	output wire [7:0] data);

	always @(posedge clk) begin
		if (reset)
			data <= 8'd0;
		else
			data <= data + 1;
	end

endmodule
