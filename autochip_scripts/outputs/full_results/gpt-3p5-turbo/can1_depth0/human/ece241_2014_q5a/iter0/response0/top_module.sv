module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [2:0] state;
reg [31:0] count;
reg [31:0] num;

always @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		state <= 3'b000;
		count <= 0;
		num <= 0;
	end else begin
		case(state)
			3'b000: begin // Initial state
				if (x == 1'b0) begin
					state <= 3'b001; // State for counting number of bits in input
					count <= 0;
					num <= 0;
				end else begin
					state <= 3'b100; // State for handling negative input
					count <= 0;
					num <= 0;
				end
			end
			3'b001: begin // State for counting number of bits in input
				if (x == 1'b0) begin
					state <= 3'b001;
					count <= count + 1;
				end else begin
					state <= 3'b010; // State for converting positive input
					count <= count + 1;
					num <= num + (x << count); // Shift input to appropriate position
				end
			end
			3'b010: begin // State for converting positive input
				if (count == 31) begin
					state <= 3'b011; // State for outputting the result
					count <= 0;
					num <= -num; // Negate the number
				end else begin
					state <= 3'b001; // State for counting number of bits in input
					count <= count + 1;
					num <= num + (x << count); // Shift input to appropriate position
				end
			end
			3'b011: begin // State for outputting the result
				state <= 3'b011;
				z <= num; // Output the result
			end
			3'b100: begin // State for handling negative input
				if (x == 1'b0) begin
					state <= 3'b101; // State for counting number of bits in input
					count <= 0;
					num <= 0;
				end else begin
					state <= 3'b110; // State for converting negative input
					count <= 0;
					num <= 0;
				end
			end
			3'b101: begin // State for counting number of bits in input
				if (x == 1'b0) begin
					state <= 3'b101;
					count <= count + 1;
				end else begin
					state <= 3'b110; // State for converting negative input
					count <= count + 1;
				end
			end
			3'b110: begin // State for converting negative input
				if (count == 31) begin
					state <= 3'b011; // State for outputting the result
					count <= 0;
					num <= num - (x << count); // Shift input to appropriate position
				end else begin
					state <= 3'b101; // State for counting number of bits in input
					count <= count + 1;
					num <= num - (x << count); // Shift input to appropriate position
				end
			end
		endcase
	end
end

endmodule
