module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @* begin
    case (a | b | c | d)
        0: out = 0;
        1: out = 0;
        3: out = 1;
        2: out = 1;
        4: out = 1'bx;
        5: out = 0;
        7: out = 0;
        6: out = 0;
        c: out = 1;
        d: out = 1'bx;
        f: out = 1;
        e: out = 1;
        8: out = 1;
        9: out = 1'bx;
        b: out = 1;
        a: out = 1;
    endcase
end

endmodule
