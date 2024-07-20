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

always@(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
		fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b0;
	end else begin
		case(state)
			3'b000: begin
				if (s == 3'b111)
					state <= 3'b000;
				else if (s == 3'b110 || s == 3'b101)
					state <= 3'b010;
				else if (s == 3'b100)
					state <= 3'b001;
				else if (s == 3'b000)
					state <= 3'b111;
			end
			
			3'b001: begin
				if (s == 3'b110)
					state <= 3'b010;
				else if (s == 3'b100)
					state <= 3'b001;
				else if (s == 3'b000)
					state <= 3'b111;
			end
			
			3'b010: begin
				if (s == 3'b100)
					state <= 3'b001;
				else if (s == 3'b000)
					state <= 3'b111;
			end
			
			3'b111: begin
				if (s == 3'b111)
					state <= 3'b000;
				else if (s == 3'b110 || s == 3'b101)
					state <= 3'b010;
				else if (s == 3'b100)
					state <= 3'b001;
			end
		endcase
	end
end

always@(state) begin
	case(state)
		3'b000: begin
			fr3 <= 1'b1;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b0;
		end
		
		3'b001: begin
			fr3 <= 1'b0;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b0;
		end
		
		3'b010: begin
			fr3 <= 1'b0;
			fr2 <= 1'b0;
			fr1 <= 1'b1;
			dfr <= 1'b0;
		end
		
		3'b111: begin
			fr3 <= 1'b0;
			fr2 <= 1'b0;
			fr1 <= 1'b0;
			dfr <= 1'b1;
		end
	endcase
end

endmodule
