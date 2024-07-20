module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [1:0] state;
reg [2:0] match_count;

parameter IDLE = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

always @(posedge clk or negedge aresetn) begin
	if (~aresetn) begin
		state <= IDLE;
		match_count <= 0;
		z <= 0;
	end else begin
		case(state)
			IDLE: begin
				if (x == 1'b1) begin
					state <= S1;
					match_count <= 1;
				end else begin
					state <= IDLE;
					match_count <= 0;
				end
			end
			S1: begin
				if (x == 1'b0) begin
					state <= IDLE;
					match_count <= 0;
				end else if (x == 1'b1) begin
					if (match_count == 2) begin
						state <= S2;
						match_count <= 3;
					end else begin
						state <= S1;
						match_count <= match_count + 1;
					end
				end
			end
			S2: begin
				if (x == 1'b1) begin
					state <= S1;
					match_count <= 1;
				end else begin
					state <= IDLE;
					match_count <= 0;
				end
			end
		endcase
	end
end

always @(posedge clk or negedge aresetn) begin
	if (~aresetn) begin
		z <= 0;
	end else begin
		if (state == S2 && match_count == 3) begin
			z <= 1;
		end else begin
			z <= 0;
		end
	end
end

endmodule
