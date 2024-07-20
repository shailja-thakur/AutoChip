module top_module(
    input wire clk,
    input wire reset,
    output wire data_out,
    output wire valid_out);

	// internal signals
	reg [1:0] state;
	reg [3:0] counter;
	reg [7:0] data;

	// state parameter
	localparam IDLE = 2'b00;
	localparam WAIT = 2'b01;
	localparam PROCESS = 2'b10;
	localparam DONE = 2'b11;

	// reset values
	always @(posedge reset) begin
		state <= IDLE;
		counter <= 0;
		data <= 0;
	end

	// FSM logic
	always @(posedge clk) begin
		case(state)
			IDLE: begin
				data <= 0;
				counter <= 0;
				if (reset) begin
					state <= IDLE;
				end else begin
					state <= WAIT;
				end
			end

			WAIT: begin
				data <= 0;
				counter <= counter + 1;
				if (counter >= 4'd9) begin
					state <= PROCESS;
				end else begin
					state <= WAIT;
				end
			end

			PROCESS: begin
				data <= in;
				state <= DONE;
			end

			DONE: begin
				valid_out <= 1;
				state <= IDLE;
			end
		endcase
	end

	// data output logic
	assign data_out = data;

endmodule
