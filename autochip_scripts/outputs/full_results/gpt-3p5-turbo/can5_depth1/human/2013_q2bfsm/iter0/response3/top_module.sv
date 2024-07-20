module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state;
reg f;
reg g;
reg [2:0] count;
always @(posedge clk or negedge resetn) begin
	if(!resetn) begin
		state <= 2'b00;
		f <= 1'b0;
		g <= 1'b0;
	end else begin
		case(state)
			2'b00: begin
				f <= 1'b0;
				g <= 1'b0;
				if(x == 1'b1) begin
					state <= 2'b01;
					count <= 3'b001;
				end
			end
			2'b01: begin
				if(count == 3'b100) begin
					g <= 1'b1;
					state <= 2'b10;
				end else if(x == 1'b1) begin
					count <= count + 1'b1;
				end else begin
					count <= 3'b001;
					state <= 2'b00;
				end
			end
			2'b10: begin
				if(y == 1'b0) begin
					g <= 1'b0;
					state <= 2'b00;
				end
			end
		endcase
	end
end

endmodule
