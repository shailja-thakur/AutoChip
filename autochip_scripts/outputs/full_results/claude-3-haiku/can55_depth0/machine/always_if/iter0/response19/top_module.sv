module top_module (
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output out_assign,
    output reg out_always
);

    // out_assign is assigned the value of either input a or input b using an assign statement
    assign out_assign = (sel_b1 & sel_b2) ? b : a;

    // out_always is assigned the value of either input a or input b using an always block
    always @(*) begin
        if (sel_b1 & sel_b2)
            out_always = b;
        else
            out_always = a;
    end

endmodule
