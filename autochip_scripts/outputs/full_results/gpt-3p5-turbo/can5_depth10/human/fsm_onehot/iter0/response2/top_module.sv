module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	reg [9:0] next_state;
	reg out1, out2;

	always @(state or in) begin
		case(state)
			10'b1_000_000_000:
				if(in == 1'b0) begin
					next_state = 10'b1_000_000_000;
					out1 = 1'b0;
					out2 = 1'b0;
				end else begin
					next_state = 10'b0_000_000_001;
					out1 = 1'b0;
					out2 = 1'b0;
				end
			10'b0_000_000_001:
				if(in == 1'b0) begin
					next_state = 10'b1_000_000_000;
					out1 = 1'b0;
					out2 = 1'b0;
				end else begin
					next_state = 10'b0_000_000_010;
					out1 = 1'b0;
					out2 = 1'b0;
				end
			10'b0_000_000_010:
				if(in == 1'b0) begin
					next_state = 10'b1_000_000_000;
					out1 = 1'b0;
					out2 = 1'b0;
				end else begin
					next_state = 10'b0_000_000_011;
					out1 = 1'b0;
					out2 = 1'b0;
				end
			10'b0_000_000_011:
				if(in == 1'b0) begin
					next_state = 10'b1_000_000_000;
					out1 = 1'b0;
					out2 = 1'b0;
				end else begin
					next_state = 10'b0_000_000_100;
					out1 = 1'b0;
					out2 = 1'b0;
				end
			10'b0_000_000_100:
				if(in == 1'b0) begin
					next_state = 10'b1_000_000_000;
					out1 = 1'b0;
					out2 = 1'b0;
				end else begin
					next_state = 10'b0_000_000_101;
					out1 = 1'b0;
					out2 = 1'b0;
				end
			10'b0_000_000_101:
				if(in == 1'b0) begin
					next_state = 10'b0_000_001_000;
					out1 = 1'b0;
					out2 = 1'b0;
				end else begin
					next_state = 10'b0_000_000_110;
					out1 = 1'b0;
					out2 = 1'b0;
				end
			10'b0_000_000_110:
				if(in == 1'b0) begin
					next_state = 10'b0_000_010_000;
					out1 = 1'b0;
					out2 = 1'b0;
				end else begin
					next_state = 10'b0_000_000_111;
					out1 = 1'b0;
					out2 = 1'b0;
				end
			10'b0_000_000_111:
				if(in == 1'b0) begin
					next_state = 10'b0_000_100_000;
					out1 = 1'b0;
					out2 = 1'b0;
				end else begin
					next_state = 10'b0_000_000_001;
					out1 = 1'b0;
					out2 = 1'b0;
				end
			10'b0_000_001_000:
				if(in == 1'b0) begin
					next_state = 10'b1_000_000_000;
					out1 = 1'b0;
					out2 = 1'b0;
				end else begin
					next_state = 10'b0_000_000_001;
					out1 = 1'b0;
					out2 = 1'b0;
				end
			default:
				next_state = 10'b1_000_000_000;
				out1 = 1'b0;
				out2 = 1'b0;
		endcase
	end

endmodule
