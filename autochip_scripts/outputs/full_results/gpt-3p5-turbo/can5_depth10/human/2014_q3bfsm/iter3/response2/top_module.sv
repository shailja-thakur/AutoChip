module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] y_reg;
reg [2:0] y_next;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		y_reg <= 3'b000;
	end else begin
		y_reg <= y_next;
	end
end

always @(*) begin
	case (y_reg)
		3'b000: begin
			if (x) begin
				y_next = 3'b001;
				z = 1'b0;
			end else begin
				y_next = 3'b000;
				z = 1'b0;
			end
		end

		3'b001: begin
			if (x) begin
				y_next = 3'b100;
				z = 1'b0;
			end else begin
				y_next = 3'b001;
				z = 1'b0;
			end
		end

		3'b010: begin
			if (x) begin
				y_next = 3'b001;
				z = 1'b0;
			end else begin
				y_next = 3'b010;
				z = 1'b0;
			end
		end

		3'b011: begin
			if (x) begin
				y_next = 3'b010;
				z = 1'b1;
			end else begin
				y_next = 3'b001;
				z = 1'b0;
			end
		end

		3'b100: begin
			if (x) begin
				y_next = 3'b011;
				z = 1'b1;
			end else begin
				y_next = 3'b100;
				z = 1'b1;
			end
		end

        default: begin
            y_next = 3'b000;
            z = 1'b0;
        end
	endcase
end

endmodule
