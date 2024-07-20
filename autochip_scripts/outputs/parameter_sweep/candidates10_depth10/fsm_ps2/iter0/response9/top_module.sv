module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg [7:0] byte_count;
reg done;

parameter IDLE = 2'b00;
parameter FOUND = 2'b01;
parameter RECEIVING = 2'b10;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		byte_count <= 0;
		done <= 0;
	end else begin
		case (state)
			IDLE: begin
				if (in[3]) begin
					state <= FOUND;
					byte_count <= 1;
				end
			end
			FOUND: begin
				if (byte_count == 3) begin
					state <= RECEIVING;
					byte_count <= 1;
				end else if (in[3]) begin
					byte_count <= byte_count + 1;
				end else begin
					state <= IDLE;
					byte_count <= 0;
				end
			end
			RECEIVING: begin
				if (byte_count == 3) begin
					state <= FOUND;
					done <= 1;
				end else if (in[3]) begin
					state <= RECEIVING;
					byte_count <= byte_count + 1;
				end else begin
					state <= IDLE;
					byte_count <= 0;
				end
			end
		endcase
	end
end

endmodule
