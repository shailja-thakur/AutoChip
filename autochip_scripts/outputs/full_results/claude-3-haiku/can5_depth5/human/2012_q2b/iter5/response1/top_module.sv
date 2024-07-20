module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

assign Y1 = (y == 6'b000001) ? w :   // State A
           (y == 6'b000010) ? ~w :  // State B
           (y == 6'b001000) ? 1'b0 : // State D
           1'b0;

assign Y3 = (y == 6'b000010) ? w :   // State B
           (y == 6'b000100) ? ~w :  // State C
           (y == 6'b001000) ? w :   // State D
           (y == 6'b100000) ? ~w :  // State F
           1'b0;

endmodule
