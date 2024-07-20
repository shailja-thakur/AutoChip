module top_module (
	input wire [5:0] y,
	input wire w,
	input wire clk,
	output reg Y1,
	output reg Y3
);

	reg [5:0] next_y;

	always @(posedge clk) begin
		case (y)
			6'b000001: begin // A
				Y1 <= w;
				Y3 <= w;
				next_y <= 6'b000010;
			end
			6'b000010: begin // B
				Y1 <= w;
				Y3 <= w;
				next_y <= 6'b000001;
			end
			6'b000100: begin // C
				Y1 <= w;
				Y3 <= w;
				next_y <= 6'b001000;
			end
			6'b001000: begin // D
				Y1 <= w;
				Y3 <= w;
				next_y <= 6'b010000;
			end
			6'b010000: begin // E
				Y1 <= Y1;
				Y3 <= Y3;
				if (w)
					next_y <= 6'b010000;
				else
					next_y <= 6'b001000;
			end
			6'b100000: begin // F
				Y1 <= Y3;
				Y3 <= w;
				next_y <= 6'b000100;
			end
			default: begin
				Y1 <= 1'b0;
				Y3 <= 1'b0;
				next_y <= 6'b000001;
			end
		endcase
	end

	always @(posedge clk) begin
		y <= next_y;
	end
	
endmodule
