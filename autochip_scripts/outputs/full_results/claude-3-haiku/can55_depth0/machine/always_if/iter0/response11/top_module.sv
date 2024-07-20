module top_module (
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output out_assign,
    output reg out_always
);

    // out_assign is assigned the value of input b if both sel_b1 and sel_b2 are 1, otherwise it is assigned the value of input a
    assign out_assign = (sel_b1 & sel_b2) ? b : a;

    // out_always is assigned the value of input b if both sel_b1 and sel_b2 are 1, otherwise it is assigned the value of input a
    always @(a, b, sel_b1, sel_b2) begin
        if (sel_b1 & sel_b2) begin
            out_always = b;
        end else begin
            out_always = a;
        end
    end

endmodule
