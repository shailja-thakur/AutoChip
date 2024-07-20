module top_module (
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output out_assign,
    output reg out_always
);

    // Assign output based on select signals
    assign out_assign = (sel_b1 & sel_b2) ? b : a;

    // Always block to assign output based on select signals
    always @(*) begin
        if (sel_b1 & sel_b2)
            out_always = b;
        else
            out_always = a;
    end

endmodule
