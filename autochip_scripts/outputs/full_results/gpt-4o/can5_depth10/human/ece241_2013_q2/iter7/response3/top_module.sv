module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Lookup tables for Sum-of-Products (SOP) and Product-of-Sums (POS)
    wire [3:0] in = {a, b, c, d};
    wire sop, pos;
  
    assign sop =  (in == 4'b0010) ||   // 2
                  (in == 4'b0111) ||   // 7
                  (in == 4'b1111);     // 15

    assign pos =  !( (in != 4'b0000) &&   // Not 0
                     (in != 4'b0001) &&   // Not 1
                     (in != 4'b0100) &&   // Not 4
                     (in != 4'b0101) &&   // Not 5
                     (in != 4'b0110) &&   // Not 6
                     (in != 4'b1001) &&   // Not 9
                     (in != 4'b1010) &&   // Not 10
                     (in != 4'b1101) &&   // Not 13
                     (in != 4'b1110));    // Not 14

    assign out_sop = sop;
    assign out_pos = pos;

endmodule
