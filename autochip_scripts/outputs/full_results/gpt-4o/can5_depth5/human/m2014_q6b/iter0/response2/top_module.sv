module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 1'b0;    // A -> Can't transition to affect y2
            3'b001: Y2 = ~w;      // B -> If w=0, goto C (y[2]=1), if w=1, goto D (y[2]=0)
            3'b010: Y2 = 1'b1;    // C -> Always goto E or D which both have y[2] as 1
            3'b011: Y2 = ~w;      // D -> If w=0, goto F (y[2]=1), if w=1, goto A (y[2]=0)
            3'b100: Y2 = 1'b0;    // E -> Can't transition to affect y2
            3'b101: Y2 = 1'b0;    // F -> Both transitions will cause y2 to be 0 or reset
            default: Y2 = 1'b0;   // Default case
        endcase
    end
endmodule
