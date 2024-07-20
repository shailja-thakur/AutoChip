module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	assign next_state = 10'b0;
	assign out1 = 1'b0;
	assign out2 = 1'b0;

	always @* begin
		case(state)
			10'b0000000001: begin
				if (in == 1'b0) begin
					next_state = 10'b0000000001;
				end else begin
					next_state = 10'b0000000010;
				end
			end
			10'b0000000010: begin
				if (in == 1'b0) begin
					next_state = 10'b0000000001;
				end else begin
					next_state = 10'b0000000011;
				end
			end
			10'b0000000011: begin
				if (in == 1'b0) begin
					next_state = 10'b0000000001;
				end else begin
					next_state = 10'b0000000100;
				end
			end
			10'b0000000100: begin
				if (in == 1'b0) begin
					next_state = 10'b0000000001;
				end else begin
					next_state = 10'b0000000101;
				end
			end
			10'b0000000101: begin
				if (in == 1'b0) begin
					next_state = 10'b0000001000;
				end else begin
					next_state = 10'b0000000110;
				end
			end
			10'b0000000110: begin
				if (in == 1'b0) begin
					next_state = 10'b0000001001;
				end else begin
					next_state = 10'b0000000111;
				end
			end
			10'b0000000111: begin
				if (in == 1'b0) begin
					next_state = 10'b0000000001;
				end else begin
					next_state = 10'b0000000111;
				end
			end
			10'b0000001000: begin
				if (in == 1'b0) begin
					next_state = 10'b0000000001;
				end else begin
					next_state = 10'b0000000010;
				end
			end
			10'b0000001001: begin
				if (in == 1'b0) begin
					next_state = 10'b0000000001;
				end else begin
					next_state = 10'b0000000010;
				end
			end
			10'b0000001010: begin
				if (in == 1'b0) begin
					next_state = 10'b0000000001;
				end else begin
					next_state = 10'b0000000010;
				end
			end
			default: begin
				next_state = 10'b0;
			end
		endcase
	end

	always @* begin
		case(state)
			10'b0000000111: begin
				out1 = 1'b0;
				out2 = 1'b1;
			end
			10'b0000001000: begin
				out1 = 1'b1;
				out2 = 1'b0;
			end
			10'b0000001001: begin
				out1 = 1'b1;
				out2 = 1'b1;
			end
			default: begin
				out1 = 1'b0;
				out2 = 1'b0;
			end
		endcase
	end

endmodule
