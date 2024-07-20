module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	// State flip-flop declarations
	reg y1_ff;
	reg y3_ff;
  
	// Combinational logic for deriving Y1 and Y3
	always @(*) begin
		case(y)
			6'b000001: begin
				Y1 = w;
				Y3 = 1'b0;
			end
			6'b000010: begin
				Y1 = w;
				Y3 = 1'b0;
			end
			6'b000100: begin
				Y1 = w;
				Y3 = 1'b0;
			end
			6'b001000: begin
				Y1 = w;
				Y3 = 1'b0;
			end
			6'b010000: begin
				Y1 = w;
				Y3 = 1'b0;
			end
			6'b100000: begin
				Y1 = w;
				Y3 = 1'b1;
			end
			default: begin
				Y1 = 1'b0;
				Y3 = 1'b0;
			end
		endcase
	end
	
	// State flip-flop declarations
	always @(posedge clk or negedge reset) begin
		if (reset == 0) begin
			y1_ff <= 1'b0;
			y3_ff <= 1'b0;
		end else begin
			y1_ff <= Y1;
			y3_ff <= Y3;
		end
	end

	assign Y1 = y1_ff;
	assign Y3 = y3_ff;

endmodule
