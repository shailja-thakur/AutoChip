module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [7:0] state;
reg [7:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 8'b0000_0001; // initial state BYTE1
	end else begin
		state <= next_state;
	end
end

always @(state, in) begin
	case (state)
		8'b0000_0001: begin // BYTE1 state
			if (in[2] == 1) begin
				next_state <= 8'b0000_0010; // transition to BYTE2 state
			end else begin
				next_state <= 8'b0000_0001; // remain in BYTE1 state
			end
		end
		
		8'b0000_0010: begin // BYTE2 state
			next_state <= 8'b0000_0100; // transition to BYTE3 state
		end
		
		8'b0000_0100: begin // BYTE3 state
			next_state <= 8'b0000_1000; // transition to DONE state
		end
		
		8'b0000_1000: begin // DONE state
			if (in[2] == 1) begin
				next_state <= 8'b0000_0010; // transition to BYTE2 state
			end else begin
				next_state <= 8'b0000_0001; // transition to BYTE1 state
			end
		end
		
		default: begin
			next_state <= 8'b0000_0001; // default to BYTE1 state
		end
	endcase
end

assign done = (state == 8'b0000_1000);

endmodule
