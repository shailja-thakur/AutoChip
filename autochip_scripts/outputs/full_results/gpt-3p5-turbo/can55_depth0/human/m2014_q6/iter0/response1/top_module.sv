module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			case (state)
				3'b000: begin  // A
					if (w) begin
						state <= 3'b000;
					end else begin
						state <= 3'b001;
					end
				end
				3'b001: begin  // B
					if (w) begin
						state <= 3'b010;
					end else begin
						state <= 3'b001;
					end
				end
				3'b010: begin  // C
					if (w) begin
						state <= 3'b011;
					end else begin
						state <= 3'b100;
					end
				end
				3'b011: begin  // D
					if (w) begin
						state <= 3'b100;
					end else begin
						state <= 3'b001;
					end
				end
				3'b100: begin  // E
					if (w) begin
						state <= 3'b100;
					end else begin
						state <= 3'b011;
					end
				end
				3'b101: begin  // F
					if (w) begin
						state <= 3'b010;
					end else begin
						state <= 3'b011;
					end
				end
			endcase
		end
	end
	
	assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;

endmodule
