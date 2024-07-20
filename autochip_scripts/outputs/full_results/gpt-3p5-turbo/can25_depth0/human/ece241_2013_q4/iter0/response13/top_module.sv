module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [2:0] state;
reg fr1_prev;
reg fr2_prev;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
		fr1_prev <= 0;
		fr2_prev <= 0;
	end else begin
		case(state)
			3'b000: begin // Above s[3]
				fr1 <= 0;
				fr2 <= 0;
				fr3 <= 0;
				dfr <= 0;
				if (s == 3'b111) state <= 3'b001;
			end
			3'b001: begin // Between s[3] and s[2]
				fr1 <= 1;
				fr2 <= 0;
				fr3 <= 0;
				dfr <= 0;
				if (s == 3'b110) state <= 3'b010;
				else if (s == 3'b101) state <= 3'b011;
			end
			3'b010: begin // Between s[2] and s[1]
				fr1 <= 1;
				fr2 <= 1;
				fr3 <= 0;
				dfr <= 0;
				if (s == 3'b101) state <= 3'b011;
				else if (s == 3'b100) state <= 3'b100;
			end
			3'b011: begin // Below s[1]
				fr1 <= 1;
				fr2 <= 1;
				fr3 <= 1;
				dfr <= 0;
				if (s == 3'b100) state <= 3'b100;
			end
			3'b100: begin // Reset state
				fr1 <= 0;
				fr2 <= fr2_prev;
				fr3 <= fr3_prev;
				dfr <= 1;
				if (s == 3'b000) state <= 3'b000;
			end
		endcase
	end
end

always @(posedge clk) begin
	fr1_prev <= fr1;
	fr2_prev <= fr2;
	fr3_prev <= fr3;
end

endmodule
