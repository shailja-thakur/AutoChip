module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);


// Register to hold the current state
reg [3:0] state;

// Combinational Logic block to determine the next state
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 4'b0000; // Reset to initial state (S)
	end else begin
		case (state)
			4'b0000: if (data) state <= 4'b0001; else state <= 4'b0000;
			4'b0001: if (data) state <= 4'b0011; else state <= 4'b0000;
			4'b0011: if (data) state <= 4'b0011; else state <= 4'b0110;
			4'b0110: if (data) state <= 4'b1111; else state <= 4'b0000;
			4'b1111: state <= 4'b1111;
		endcase
	end
end

// Assign output based on current state
assign start_shifting = (state == 4'b1111) ? 1'b1 : 1'b0;

endmodule
