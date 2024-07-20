module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	reg [2:0] state, next_state;
	reg [2:0] count;

	// State encoding
	localparam S0 = 3'b000; // Initial state
	localparam S1 = 3'b001; // 0 detected
	localparam S2 = 3'b010; // 01 detected
	localparam S3 = 3'b011; // 011 detected
	localparam S4 = 3'b100; // 0111 detected
	localparam S5 = 3'b101; // 01111 detected
	localparam S6 = 3'b110; // 011111 detected
	localparam S7 = 3'b111; // 0111111 or error state

	// State transition and output logic
	always @ (posedge clk) begin
		if (reset) begin
			state <= S0;
			count <= 3'b000;
		end else begin
			state <= next_state;
			count <= (in == 1) ? count + 1 : 3'b000;
		end
	end

	always @ (*) begin
		// Default outputs
		disc = 1'b0;
		flag = 1'b0;
		err = 1'b0;
		next_state = state;

		case (state)
			S0: begin
				if (in == 1'b0) begin
					next_state = S1;
				end
			end
			S1: begin
				if (in == 1'b1) begin
					next_state = S2;
				end else begin
					next_state = S1;
				end
			end
			S2: begin
				if (in == 1'b1) begin
					next_state = S3;
				end else begin
					next_state = S1;
				end
			end
			S3: begin
				if (in == 1'b1) begin
					next_state = S4;
				end else begin
					next_state = S1;
				end
			end
			S4: begin
				if (in == 1'b1) begin
					next_state = S5;
				end else begin
					next_state = S1;
				end
			end
			S5: begin
				if (in == 1'b1) begin
					next_state = S6;
				end else begin
					next_state = S1;
				end
			end
			S6: begin
				if (in == 1'b1) begin
					next_state = S7;
				end else begin
					next_state = S1;
					disc = 1'b1;
				end
			end
			S7: begin
				if (in == 1'b0) begin
					next_state = S1;
					flag = 1'b1;
				end else begin
					next_state = S7;
					err = 1'b1;
				end
			end
			default: next_state = S0;
		endcase
	end

endmodule
