module top_module(
    input [3:0] y,
    input w,
    output reg Y2);

    always @* begin
        case ({y, w})
            5'b000_0: Y2 = 0;
            5'b000_1: Y2 = 0;
            5'b001_0: Y2 = 1;
            5'b001_1: Y2 = 1;
            5'b010_0: Y2 = 0;
            5'b010_1: Y2 = 1;
            5'b011_0: Y2 = 0;
            5'b011_1: Y2 = 0;
            5'b100_0: Y2 = 0;
            5'b100_1: Y2 = 1;
            5'b101_0: Y2 = 1;
            5'b101_1: Y2 = 1;
            default:  Y2 = 0; // default case to handle all other input combinations
        endcase
    end
endmodule
