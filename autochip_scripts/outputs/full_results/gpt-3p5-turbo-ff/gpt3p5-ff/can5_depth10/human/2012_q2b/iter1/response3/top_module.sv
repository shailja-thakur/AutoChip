module top_module (
	input [5:0] y,
	input w,
	output reg Y1,
	output reg Y3
);

reg [5:0] y_reg;

always @(posedge w) begin
    y_reg <= y;
end

always @(*) begin
    case(y_reg)
        6'b000001: begin
            Y1 = 0;
            Y3 = 0;
        end
        6'b000010: begin
            Y1 = 0;
            Y3 = 0;
        end
        6'b000100: begin
            Y1 = 0;
            Y3 = 1;
        end
        6'b001000: begin
            Y1 = 1;
            Y3 = 0;
        end
        6'b010000: begin
            Y1 = 0;
            Y3 = 0;
        end
        6'b100000: begin
            Y1 = 0;
            Y3 = 1;
        end
        default: begin
            Y1 = 0;
            Y3 = 0;
        end
    endcase
end

endmodule
