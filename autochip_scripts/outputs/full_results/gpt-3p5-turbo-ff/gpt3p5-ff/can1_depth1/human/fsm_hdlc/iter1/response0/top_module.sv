module top_module (
	input clk,
	input reset,
	input in,
	output wire disc,
	output wire flag,
	output wire err);

	// Define states
	reg [1:0] state;

	// Define internal signals
	reg in_prev;
	reg [2:0] count;

	// Initialize state
	initial begin
		state = 2'b00;
	end

	// Next state and output logic
	always @(posedge clk) begin
		if (reset) begin
			state <= 2'b00;
		end
		else begin
			case (state)
				2'b00: begin // S0
					if (in) begin
						state <= 2'b01;
						in_prev <= in;
						count <= 3'b001;
					end
					else begin
						state <= 2'b00;
					end
				end

				2'b01: begin // S1
					if (in) begin
						if (in_prev == in) begin
							count <= count + 1;
						end
						else begin
							count <= 3'b010;
						end
						in_prev <= in;
						state <= 2'b10;
					end
					else begin
						state <= 2'b00;
					end
				end

				2'b10: begin // S2
					if (in) begin
						if (count >= 3'b111) begin
							state <= 2'b11;
							err <= 1;
						end
						else begin
							count <= count + 1;
							state <= 2'b10;
						end
					end
					else begin
						state <= 2'b00;
						if (count == 3'b101) begin
							disc <= 1;
						end
						else begin
							disc <= 0;
						end
					end
				end

				2'b11: begin // S3
					if (in) begin
						state <= 2'b11;
					end
					else begin
						state <= 2'b00;
						err <= 0;
					end
				end
			endcase
		end
	end

	// Assign outputs based on state
	assign flag = (state == 2'b10);
	assign disc = (state == 2'b10) & (count == 3'b101);
	assign err = (state == 2'b11);
endmodule
