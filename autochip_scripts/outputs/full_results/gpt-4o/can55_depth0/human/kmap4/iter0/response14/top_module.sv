module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    always @(*) begin
        // Sum of minterms: 1, 3, 4, 6, 9, 11, 12, 14
        // sop expression: c'd'a'b + c'dab' + cd'a'b + cdab'        
        out = (~c & ~d & a & b) | (~c & d & a & ~b) | (c & ~d & ~a & b) | (c & d & ~a & ~b);
    end

endmodule
