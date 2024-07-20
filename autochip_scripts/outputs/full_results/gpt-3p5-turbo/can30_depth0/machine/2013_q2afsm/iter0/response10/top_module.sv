module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output reg [2:0] g
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= 3'b001;
	end else begin
		state <= next_state;
	end
end

always @(*) begin
	case (state)
		3'b001: begin
			if (r[2]) begin
				next_state = 3'b100;
			end else if (r[1]) begin
				next_state = 3'b010;
			end else if (r[0]) begin
				next_state = 3'b001;
			end else begin
				next_state = 3'b001;
			end
			g = 3'b000;
		end
		
		3'b010: begin
			if (r[1]) begin
				next_state = 3'b010;
			end else begin
				next_state = 3'b001;
			end
			g = 3'b001;
		end
		
		3'b100: begin
			if (r[2]) begin
				next_state = 3'b100;
			end else begin
				next_state = 3'b001;
			end
			g = 3'b010;
		end
		
		default: begin
			next_state = 3'b001;
			g = 3'b000;
		end
	endcase
end

endmodule
