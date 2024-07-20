module top_module (
    input [3:0] in,
    output reg [1:0] pos
);
    always @(in)
        case(in)
            0, 1:
                pos <= 0;
            2, 6, 10, 14:
                pos <= 1;
            4, 12:
                pos <= 2;
            8:
                pos <= 3;
            default:
                pos <= 0;
        endcase
endmodule
