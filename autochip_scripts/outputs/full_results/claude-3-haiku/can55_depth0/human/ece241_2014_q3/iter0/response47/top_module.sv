module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire t1, t2, t3, t4;

    // First 2-to-1 mux
    assign t1 = (c & d) | (!c & !d);
    assign t2 = (c & !d) | (!c & d);

    // Second 2-to-1 mux
    assign t3 = (t1 & !d) | (t2 & d);
    assign t4 = (t1 & d) | (t2 & !d);

    // 4-to-1 mux
    assign mux_in = {t4, t3, 2'b00};

endmodule
