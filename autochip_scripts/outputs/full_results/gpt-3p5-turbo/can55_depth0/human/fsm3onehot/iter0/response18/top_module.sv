module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

always @(*) begin
	case(state)
		4'b0001: begin // A
			if(in) begin
				next_state = 4'b0010; // B
			end
			else begin
				next_state = 4'b0001; // A
			end
			out = 1'b0;
		end
		4'b0010: begin // B
			if(in) begin
				next_state = 4'b0010; // B
			end
			else begin
				next_state = 4'b0100; // C
			end
			out = 1'b0;
		end
		4'b0100: begin // C
			if(in) begin
				next_state = 4'b0001; // A
			end
			else begin
				next_state = 4'b1000; // D
			end
			out = 1'b0;
		end
		4'b1000: begin // D
			if(in) begin
				next_state = 4'b0100; // C
			end
			else begin
				next_state = 4'b0010; // B
			end
			out = 1'b1;
		end
	endcase
end

endmodule
