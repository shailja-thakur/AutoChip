module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

always @(*) begin
    case (y)
        6'b000001: begin
            Y1 = w;
            Y3 = 1'b0;
        end
        6'b000010: begin
            Y1 = !w;
            Y3 = w;
        end
        6'b000100: begin
            Y1 = 1'b0;
            Y3 = !w;
        end
        6'b001000: begin
            Y1 = w;
            Y3 = w;
        end
        6'b010000: begin
            Y1 = 1'b0;
            Y3 = 1'b0;
        end
        6'b100000: begin
            Y1 = w;
            Y3 = w;
        end
        default: begin
            Y1 = 1'b0;
            Y3 = 1'b0;
        end
    endcase
end

endmodule
