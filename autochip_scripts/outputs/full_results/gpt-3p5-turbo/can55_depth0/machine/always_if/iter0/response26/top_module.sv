module top_module (
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output out_assign,
    output reg out_always
);

    reg out_assign_reg; // Create a register for out_assign output

    // Assign statement for out_assign output
    assign out_assign = (sel_b1 & sel_b2) ? b : a;

    // Always block for out_always output
    always @(a, b, sel_b1, sel_b2)
    begin
        if (sel_b1 & sel_b2)
            out_always <= b;
        else
            out_always <= a;
    end

endmodule
