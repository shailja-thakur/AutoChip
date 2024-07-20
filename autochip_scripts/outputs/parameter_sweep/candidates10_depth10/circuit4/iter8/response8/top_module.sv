module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg q
);

    always @(*)
    begin
        if (a == 1'b1 && b == 1'b1) 
            q = 1'b1;
        else if (c == 1'b1 && d == 1'b0)
            q = 1'b1;
        else if (c == 1'b0 && d == 1'b1)
            q = b;
        else
            q = 1'b0;
    end

endmodule
