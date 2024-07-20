module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	reg [1:0] state, next_state;
	reg [23:0] temp_bytes;
	
	// State encoding
	localparam WAIT_HEADER = 2'b00;
	localparam BYTE_1 = 2'b01;
	localparam BYTE_2 = 2'b10;
	localparam BYTE_3 = 2'b11;

	always @(posedge clk) begin
		if (reset) begin
			state <= WAIT_HEADER;
			out_bytes <= 24'd0;
			done <= 1'b0;
		end else begin
			state <= next_state;
			if (done) begin
				out_bytes <= temp_bytes;
			end
		end
	end

	always @(*) begin
		next_state = state;
		temp_bytes = out_bytes;
		done = 1'b0;

		case (state)
			WAIT_HEADER: begin
				if (in[3] == 1'b1) begin
					temp_bytes[23:16] = in;
					next_state = BYTE_1;
				end
			end
			
			BYTE_1: begin
				temp_bytes[15:8] = in;
				next_state = BYTE_2;
			end
			
			BYTE_2: begin
				temp_bytes[7:0] = in;
				next_state = BYTE_3;
			end
			
			BYTE_3: begin
				done = 1'b1;
				next_state = WAIT_HEADER;
			end
		endcase
	end

endmodule
