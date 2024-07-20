module top_module (
    input clk,
    input reset,
    input w,
    output wire z
);

    fsm fsm_inst (
        .clk(clk),
        .reset(reset),
        .w(w),
        .z(z)
    );

endmodule
