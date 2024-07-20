module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    reg ab_or;     // OR of inputs a and b
    reg cd_or;     // OR of inputs c and d

    always @* begin
        ab_or = a | b;
        cd_or = c | d;
        q = ab_or & cd_or;
    end

endmodule
