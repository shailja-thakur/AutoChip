module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [3:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 4'b0000;
	end else begin
		case(state)
			4'b0000: begin // state A
				if (s) begin
					state <= 4'b0010; // state B
				end
			end
			
			4'b0010: begin // state B
				if (w) begin
					state <= 4'b1001; // state S11
				end else begin
					state <= 4'b1000; // state S10
				end
			end
			
			4'b0011: begin // state C
				if (w) begin
					state <= 4'b1001; // state S11
				end else begin
					state <= 4'b1000; // state S10
				end
			end
			
			4'b1000: begin // state S10
				if (w) begin
					state <= 4'b1011; // state S21
				end else begin
					state <= 4'b1010; // state S20
				end
			end
			
			4'b1001: begin // state S11
				if (w) begin
					state <= 4'b1100; // state S22
				end else begin
					state <= 4'b1011; // state S21
				end
			end
			
			4'b1010: begin // state S20
				state <= 4'b0010; // state B
			end
			
			4'b1011: begin // state S21
				if (w) begin
					state <= 4'b0011; // state C
				end else begin
					state <= 4'b0010; // state B
				end
			end
			
			4'b1100: begin // state S22
				if (w) begin
					state <= 4'b0010; // state B
				end else begin
					state <= 4'b0011; // state C
				end
			end
		endcase
	end
end

always @(posedge clk) begin
	case(state)
		4'b0010: begin // state B
			z <= 1'b1;
		end
		
		4'b1000: begin // state S10
			z <= 1'b0;
		end
		
		4'b0011: begin // state C
			z <= 1'b0;
		end
		
		4'b1010: begin // state S20
			z <= 1'b1;
		end
		
		default: begin
			z <= 1'b0;
		end
	endcase
end

endmodule
