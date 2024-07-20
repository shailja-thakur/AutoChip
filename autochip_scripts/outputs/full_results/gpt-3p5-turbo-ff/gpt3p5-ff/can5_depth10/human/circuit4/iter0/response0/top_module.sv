module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    reg q;

    always @(*) begin
        if (a & ~b & c & ~d)
            q = 1;
        else
            q = 0;
    end
endmodule
