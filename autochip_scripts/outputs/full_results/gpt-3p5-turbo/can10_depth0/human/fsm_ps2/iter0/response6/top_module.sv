module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	
	reg [2:0] state;
	reg done;
	reg [7:0] byte_count;
	reg [7:0] byte_1;
	reg [7:0] byte_2;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
			done <= 0;
			byte_count <= 0;
			byte_1 <= 0;
			byte_2 <= 0;
		end else begin
			case (state)
				3'b000: begin // Idle state
					if (in[3] == 1) begin
						state <= 3'b001;
						byte_count <= 1;
						byte_1 <= in;
					end
				end
				3'b001: begin // Receiving byte 1
					if (byte_count == 2) begin
						state <= 3'b010;
						byte_2 <= in;
					end else if (in[3] == 1) begin
						state <= 3'b000;
						byte_count <= 0;
						byte_1 <= in;
					end else begin
						byte_count <= byte_count + 1;
					end
				end
				3'b010: begin // Receiving byte 2
					if (byte_count == 3) begin
						state <= 3'b011;
						done <= 1;
					end else if (in[3] == 1) begin
						state <= 3'b000;
						byte_count <= 1;
						byte_1 <= in;
					end else begin
						byte_count <= byte_count + 1;
					end
				end
				3'b011: begin // Wait for next message
					state <= 3'b000;
					done <= 0;
					byte_count <= 0;
					byte_1 <= 0;
					byte_2 <= 0;
				end
			endcase
		end
	end
	
endmodule
