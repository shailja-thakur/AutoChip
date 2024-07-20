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

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b000;
	else begin
		// Water level above s[3]
		if (s[3])
			state <= 3'b000;
		// Water level between s[3] and s[2]
		else if (s[2])
			state <= 3'b001;
		// Water level between s[2] and s[1]
		else if (s[1])
			state <= 3'b010;
		// Water level below s[1]
		else
			state <= 3'b011;
	end
end

always @* begin
	case (state)
		// Water level above s[3]
		3'b000: begin
			fr3 <= 0;
			fr2 <= 0;
			fr1 <= 0;
			dfr <= 0;
		end
		// Water level between s[3] and s[2]
		3'b001: begin
			fr3 <= 0;
			fr2 <= 0;
			fr1 <= 1;
			dfr <= 0;
		end
		// Water level between s[2] and s[1]
		3'b010: begin
			fr3 <= 0;
			fr2 <= 1;
			fr1 <= 1;
			dfr <= 0;
		end
		// Water level below s[1]
		3'b011: begin
			fr3 <= 1;
			fr2 <= 1;
			fr1 <= 1;
			dfr <= 0;
		end
	endcase
end

endmodule
