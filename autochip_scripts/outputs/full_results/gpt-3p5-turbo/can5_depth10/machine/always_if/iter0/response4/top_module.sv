module top_module (
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output out_assign,
    output reg out_always
);

    // Assign statement to select between a and b based on sel_b1 and sel_b2
    assign out_assign = (sel_b1 & sel_b2) ? b : a;
    
    // Always block to continuously update out_always based on changes in inputs
    always @(a, b, sel_b1, sel_b2) begin
        if (sel_b1 & sel_b2)
            out_always <= b;
        else
            out_always <= a;
    end
    
endmodule
