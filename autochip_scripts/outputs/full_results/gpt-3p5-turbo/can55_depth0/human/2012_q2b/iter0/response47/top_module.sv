module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

reg Y1;
reg Y3;

always @(y or w)
begin
    case(y)
        6'b000001, 6'b000010, 6'b001000, 6'b010000: // A, B, D, E
            begin
                Y1 = 1'b0;
                Y3 = 1'b0;
            end
        6'b000100, 6'b100000: // C, F
            begin
                Y1 = 1'b1;
                Y3 = 1'b0;
            end
        6'b001000: // D
            begin
                Y1 = 1'b0;
                Y3 = 1'b1;
            end
        6'b010000: // E
            begin
                Y1 = 1'b0;
                Y3 = 1'b0;
            end
        default:
            begin
                Y1 = 1'b0;
                Y3 = 1'b0;
            end
    endcase
end

endmodule
