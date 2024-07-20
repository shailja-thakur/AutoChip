module top_module(
    input [3:0] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            4'h0, 4'h1, 4'h4, 4'h6, 4'h7, 4'h8: Y2 = 0;
            4'h2, 4'h3, 4'h5, 4'h9, 4'hA, 4'hB: Y2 = 1;
            default: Y2 = 0;
        endcase
    end
    
endmodule
