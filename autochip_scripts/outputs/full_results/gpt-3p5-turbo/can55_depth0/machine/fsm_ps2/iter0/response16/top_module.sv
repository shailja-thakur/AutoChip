module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

reg [2:0] state;
 
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
	end else begin
		case (state)
			BYTE1: begin
				if (in[2] == 1) begin
					state <= BYTE2;
				end else begin
					state <= BYTE1;
				end
			end // BYTE1
			
			BYTE2: begin
				state <= BYTE3;
			end // BYTE2
			
			BYTE3: begin
				state <= DONE;
			end // BYTE3
			
			DONE: begin
				if (in[2] == 1) begin
					state <= BYTE2;
				end else begin
					state <= BYTE1;
				end
			end // DONE
			
			default: state <= BYTE1;
		endcase
	end // if-else
end // always

assign done = (state == DONE);

endmodule
