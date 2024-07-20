module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		state <= 2'd0;
	end else begin
		state <= next_state;
	end
end

always @(*) begin
	case (state)
		2'd0: begin
			if (r[2]) begin
				next_state = 2'd1;
			end else if (r[1]) begin
				next_state = 2'd2;
			end else if (r[0]) begin
				next_state = 2'd3;
			end else begin
				next_state = 2'd0;
			end
		end
		2'd1: begin
			if (r[1]) begin
				next_state = 2'd1;
			end else begin
				next_state = 2'd0;
			end
		end
		2'd2: begin
			if (r[2]) begin
				next_state = 2'd2;
			end else begin
				next_state = 2'd0;
			end
		end
		2'd3: begin
			if (r[0]) begin
				next_state = 2'd3;
			end else begin
				next_state = 2'd0;
			end
		end
	endcase
end

always @(*) begin
	case (state)
		2'd1: begin
			g[0] = 1'b1;
			g[1] = 1'b0;
			g[2] = 1'b0;
		end
		2'd2: begin
			g[0] = 1'b0;
			g[1] = 1'b1;
			g[2] = 1'b0;
		end
		2'd3: begin
			g[0] = 1'b0;
			g[1] = 1'b0;
			g[2] = 1'b1;
		end
		default: begin
			g[0] = 1'b0;
			g[1] = 1'b0;
			g[2] = 1'b0;
		end
	endcase
end

endmodule
