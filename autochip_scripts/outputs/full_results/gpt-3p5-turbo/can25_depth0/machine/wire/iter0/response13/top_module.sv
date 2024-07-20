module top_module(
	input      clk,
	input      reset,
	output reg data_out,
	output reg valid_out
);

	// Internal signals
	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data;

	// FSM states
	localparam IDLE    = 2'b00;
	localparam WAIT    = 2'b01;
	localparam PROCESS = 2'b10;
	localparam DONE    = 2'b11;

	// Module implementation
	always @(posedge clk) begin
		if (reset == 1'b1) begin
			state <= IDLE;
			counter <= 8'd0;
			data_out <= 8'd0;
			valid_out <= 1'b0;
		end else begin
			case (state)
				IDLE: begin
					counter <= 8'd0;
					data_out <= 8'd0;
					valid_out <= 1'b0;
					if (reset == 1'b0) begin
						state <= WAIT;
					end
				end

				WAIT: begin
					counter <= counter + 1;
					data_out <= 8'd0;
					valid_out <= 1'b0;
					if (counter >= 8'd10) begin
						state <= PROCESS;
					end
				end

				PROCESS: begin
					counter <= counter + 1;
					data_out <= data;
					state <= DONE;
				end

				DONE: begin
					counter <= 8'd0;
					data_out <= data;
					valid_out <= 1'b1;
					state <= IDLE;
				end
			endcase
		end
	end

endmodule
