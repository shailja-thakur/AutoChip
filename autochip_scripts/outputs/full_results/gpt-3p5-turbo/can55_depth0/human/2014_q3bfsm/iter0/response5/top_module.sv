module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] y_next;
	reg [2:0] y;

	always @(posedge clk or posedge reset) begin
        if (reset)
            y <= 3'b000;
        else
            y <= y_next;
    end

	always @(*) begin
		case(y)
			3'b000: begin
				if (x)
					y_next = 3'b001;
				else
					y_next = 3'b000;
				z = 1'b0;
			end
			3'b001: begin
				if (x)
					y_next = 3'b100;
				else
					y_next = 3'b001;
				z = 1'b0;
			end
			3'b010: begin
				if (x)
					y_next = 3'b001;
				else
					y_next = 3'b010;
				z = 1'b0;
			end
			3'b011: begin
				if (x)
					y_next = 3'b010;
				else
					y_next = 3'b001;
				z = 1'b1;
			end
			3'b100: begin
				if (x)
					y_next = 3'b100;
				else
					y_next = 3'b011;
				z = 1'b1;
			end
		endcase
	end

endmodule
