module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [3:0] state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 4'd0;
	else begin
		case (state)
			4'd0: begin
				fr1 <= 0;
				fr2 <= 0;
				fr3 <= 0;
				dfr <= 0;
				if (s > 3'd3)
					state <= 4'd1;
				else if (s == 3'd3)
					state <= 4'd2;
				else if (s == 3'd2)
					state <= 4'd3;
				else if (s == 3'd1)
					state <= 4'd4;
			end
			4'd1: begin
				fr1 <= 0;
				fr2 <= 0;
				fr3 <= 0;
				dfr <= 0;
				if (s <= 3'd2)
					state <= 4'd2;
			end
			4'd2: begin
				fr1 <= 1;
				fr2 <= 0;
				fr3 <= 0;
				dfr <= 0;
				if (s <= 3'd1)
					state <= 4'd3;
				else if (s > 3'd3)
					state <= 4'd1;
			end
			4'd3: begin
				fr1 <= 1;
				fr2 <= 1;
				fr3 <= 0;
				dfr <= 0;
				if (s == 3'd1)
					state <= 4'd4;
				else if (s > 3'd2)
					state <= 4'd2;
			end
			4'd4: begin
				fr1 <= 1;
				fr2 <= 1;
				fr3 <= 1;
				if (s > 3'd1)
					dfr <= 1;
				else
					dfr <= 0;
				if (s == 3'd0)
					state <= 4'd0;
			end
		endcase
	end
end

endmodule
