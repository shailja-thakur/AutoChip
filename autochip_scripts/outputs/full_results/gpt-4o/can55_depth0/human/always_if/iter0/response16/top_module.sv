module top_module (
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output out_assign,
    output reg out_always
);

    // Using assign statements
    wire select_b;
    assign select_b = sel_b1 & sel_b2;
    assign out_assign = select_b ? b : a;

    // Using procedural block with if statement
    always @(*) begin
        if (sel_b1 && sel_b2)
            out_always = b;
        else
            out_always = a;
    end

endmodule
