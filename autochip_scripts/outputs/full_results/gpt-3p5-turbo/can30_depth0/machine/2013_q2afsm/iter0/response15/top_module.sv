module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	reg [3:1] state;
	reg [3:1] next;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= 3'b001;
		end
		else begin
			state <= next;
		end
	end

	always @* begin
		case (state)
			3'b001: begin
				if (r[3]) begin
					next = 3'b100;
				end
				else if (r[2]) begin
					next = 3'b010;
				end
				else if (r[1]) begin
					next = 3'b001;
				end
				else begin
					next = 3'b001;
				end
			end
			
			3'b010: begin
				if (r[2]) begin
					next = 3'b010;
				end
				else begin
					next = 3'b001;
				end
			end

			3'b100: begin
				if (r[3]) begin
					next = 3'b100;
				end
				else begin
					next = 3'b001;
				end
			end
		endcase
	end

	assign g[1] = (state == 3'b010);
	assign g[2] = (state == 3'b100);
	assign g[3] = (state == 3'b001);

endmodule
