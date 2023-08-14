module top_module (
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output wire out_assign
);

    assign out_assign = (sel_b1 && sel_b2) ? b : a;

endmodule