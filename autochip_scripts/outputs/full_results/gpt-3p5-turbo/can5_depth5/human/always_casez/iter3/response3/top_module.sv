module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

    always @* begin
        case(in)
            8'b1: pos = 0;
            8'b10: pos = 1;
            8'b100: pos = 2;
            8'b1000: pos = 3;
            8'b10000: pos = 4;
            8'b100000: pos = 5;
            8'b1000000: pos = 6;
            8'b10000000: pos = 7;
            default: pos = 0;
        endcase
    end

endmodule
