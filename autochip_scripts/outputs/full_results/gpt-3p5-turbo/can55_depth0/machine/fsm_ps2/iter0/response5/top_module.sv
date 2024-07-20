module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [7:0] state;
reg done;
reg [7:0] next_state;

parameter BYTE1 = 3'b000;
parameter BYTE2 = 3'b001;
parameter BYTE3 = 3'b010;
parameter DONE = 3'b011;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
	end else begin
		state <= next_state;
	end
end

always @(state or in) begin
	case (state)
		BYTE1: begin
			if (in[2] == 1'b1) begin
				next_state <= BYTE2;
			end else begin
				next_state <= BYTE1;
			end
		end
		
		BYTE2: begin
			next_state <= BYTE3;
		end
		
		BYTE3: begin
			next_state <= DONE;
		end
		
		DONE: begin
			if (in[2] == 1'b1) begin
				next_state <= BYTE2;
			end else begin
				next_state <= BYTE1;
			end
		end
	endcase
end

assign done = (state == DONE);

endmodule
