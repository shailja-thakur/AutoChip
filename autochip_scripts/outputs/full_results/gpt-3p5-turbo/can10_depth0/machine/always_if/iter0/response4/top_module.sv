module top_module (
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output out_assign,
    output out_always
);
    
    // Assign statement for out_assign output
    assign out_assign = (sel_b1 & sel_b2) ? b : a;
    
    // Always block for out_always output
    always @ (a or b or sel_b1 or sel_b2)
        if (sel_b1 & sel_b2)
            out_always <= b;
        else
            out_always <= a;
    
endmodule
