module top_module (
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output out_assign,
    output reg out_always
);
    
    // Assign statement to set the value of out_assign
    assign out_assign = (sel_b1 & sel_b2) ? b : a;

    // Always block to update the value of out_always
    always @(a, b, sel_b1, sel_b2)
        if (sel_b1 & sel_b2)
            out_always <= b;
        else
            out_always <= a;

endmodule
