module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    reg q;
    
    // Combinational logic
    always @* begin
        if (d == 0)
            q = 0;
        else if ((a == 1) && (b == 0) && (c == 0))
            q = 0;
        else if ((a == 0) && (b == 0) && (c == 1))
            q = 1;
        else if ((a == 0) && (b == 1) && (c == 0))
            q = 1;
        else
            q = 1;
    end
endmodule
