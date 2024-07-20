module top_module (
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output out_assign,
    output reg out_always
);

    // Assign output based on input selection
    assign out_assign = (sel_b1 && sel_b2) ? b : a;

    // Update output based on input selection
    always @(a, b, sel_b1, sel_b2) begin
        if (sel_b1 && sel_b2)
            out_always = b;
        else
            out_always = a;
    end

endmodule
