module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Internal signals
	reg [2:0] state;
	reg start_shifting;

	// Combinational logic for determining next state
	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000; // Initial state S
		end else begin
			case(state)
				3'b000: begin // state S
					if (data) begin
						state <= 3'b001; // next state S1
					end else begin
						state <= 3'b000; // next state S
					end
				end
				3'b001: begin // state S1
					if (data) begin
						state <= 3'b010; // next state S11
					end else begin
						state <= 3'b000; // next state S
					end
				end
				3'b010: begin // state S11
					if (data) begin
						state <= 3'b010; // next state S11
					end else begin
						state <= 3'b011; // next state S110
					end
				end
				3'b011: begin // state S110
					if (data) begin
						state <= 3'b100; // next state Done
					end else begin
						state <= 3'b000; // next state S
					end
				end
				3'b100: begin // state Done
					state <= 3'b100; // next state Done
				end
			endcase
		end
	end

	// Assign output based on current state
	always @ (state) begin
		if (state == 3'b100) begin // Done state
			start_shifting <= 1'b1; // output is high
		end else begin
			start_shifting <= 1'b0; // output is low
		end
	end

endmodule
