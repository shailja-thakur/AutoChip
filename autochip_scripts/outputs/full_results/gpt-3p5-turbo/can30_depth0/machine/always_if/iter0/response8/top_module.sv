module top_module (
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output out_assign,
    output reg out_always
);

    // Assign statement to assign the value of either input a or input b to out_assign
    assign out_assign = (sel_b1 & sel_b2) ? b : a;

    // Always block to update the value of out_always whenever the inputs change
    always @(a, b, sel_b1, sel_b2) begin
        if (sel_b1 & sel_b2)
            out_always = b;
        else
            out_always = a;
    end

endmodule
