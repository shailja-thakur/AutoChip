module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg f;
reg g;
reg [1:0] state;

always @(posedge clk or negedge resetn) begin
	if (~resetn)
		state <= 2'b0;
	else begin
		case (state)
			2'b0: begin
				f <= 1'b0;
				if (x) state <= 2'b1;
			end
			2'b1: begin
				f <= 1'b1;
				state <= 2'b2;
			end
			2'b2: begin
				if (x) state <= 2'b3;
				else if (~x) state <= 2'b0;
			end
			2'b3: begin
				if (x) state <= 2'b4;
				else if (~x) state <= 2'b0;
			end
			2'b4: begin
				f <= 1'b0;
				if (y) state <= 2'b5;
				else state <= 2'b6;
			end
			2'b5: begin
				f <= 1'b0;
				g <= 1'b1;
				state <= 2'b6;
			end
			2'b6: begin
				if (y) begin
					f <= 1'b0;
					g <= 1'b1;
				end else begin
					f <= 1'b0;
					g <= 1'b0;
				end
			end
			default: begin
				f <= 1'b0;
				g <= 1'b0;
				state <= 2'b0;
			end
		endcase
    end
end

endmodule
