module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

reg [2:0] state;
reg clock_edge;
reg start_detected;
reg [7:0] data_counter;

parameter START = 3'b000;
parameter IN_PROGRESS = 3'b001;
parameter VERIFY_STOP_BIT = 3'b010;
parameter BYTE_RECEIVED = 3'b011;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= START;
		start_detected <= 1'b0;
		data_counter <= 8'b0;
		done <= 1'b0;
	end else begin
		case (state)
			START:
				if (in == 1'b0) begin
					state <= IN_PROGRESS;
					start_detected <= 1'b1;
					data_counter <= 8'b0;
				end else begin
					state <= START;
				end
			IN_PROGRESS:
				if (in == 1'b0) begin
					state <= IN_PROGRESS;
					data_counter <= data_counter + 1'b1;
				end else if (data_counter == 8) begin
					state <= VERIFY_STOP_BIT;
				end
			VERIFY_STOP_BIT:
				if (in == 1'b1) begin
					state <= BYTE_RECEIVED;
				end else if (clock_edge) begin
					state <= IN_PROGRESS;
					data_counter <= 8'b0;
				end
			BYTE_RECEIVED:
				if (clock_edge) begin
					state <= START;
					done <= 1'b1;
				end
		endcase
	end
end

always @(posedge clk) begin
	clock_edge <= ~clock_edge;
end

endmodule
