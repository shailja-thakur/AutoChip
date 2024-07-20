module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    reg q;

    always @(*)
    begin
        if (a && b)
            q = 1;
        else if (c && d)
            q = 1;
        else 
            q = 0;
    end

endmodule
