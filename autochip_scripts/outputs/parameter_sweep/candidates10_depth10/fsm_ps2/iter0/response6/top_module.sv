module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

	// Define states
	parameter IDLE = 0;
	parameter SEARCHING = 1;
	parameter RECEIVING = 2;
	
	reg [1:0] state;
	reg [7:0] byte_count;
	reg [2:0] first_byte;
	reg done;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			byte_count <= 0;
			first_byte <= 0;
			done <= 0;
		end else begin
			case (state)
				IDLE:
					if (in[3] == 1) begin
						state <= SEARCHING;
						byte_count <= 1;
						first_byte <= in[2:0];
					end
				SEARCHING:
					if (in[3] == 1) begin
						state <= RECEIVING;
						byte_count <= byte_count + 1;
					end else begin
						state <= SEARCHING;
						byte_count <= 0;
						first_byte <= 0;
					end
				RECEIVING:
					if (byte_count == 3) begin
						state <= IDLE;
						done <= 1;
					end else if (in[3] == 1) begin
						byte_count <= byte_count + 1;
					end else begin
						state <= SEARCHING;
						byte_count <= 0;
						first_byte <= 0;
					end
			endcase
		end
	end

endmodule
