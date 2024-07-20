module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    // Intermediate wires
    reg w1, w2, w3;

    // First level of logic
    always @(*)
    begin
        if (~a & ~b & c & d)
            w1 = 1;
        else if (~a & c & ~d)
            w1 = 1;
        else
            w1 = 0;
    end
    
    // Second level of logic
    always @(*)
    begin
        if (~a & b & c)
            w2 = 1;
        else if (a & b & c)
            w2 = 1;
        else
            w2 = 0;
    end

    // Third level of logic
    always @(*)
    begin
        if (~c & d)
            w3 = 1;
        else if (a & ~b & c)
            w3 = 1;
        else
            w3 = 0;
    end

    // Final output
    always @(*)
    begin
        if (w1 | w2 | w3)
            q = 1;
        else
            q = 0;
    end
    
endmodule
