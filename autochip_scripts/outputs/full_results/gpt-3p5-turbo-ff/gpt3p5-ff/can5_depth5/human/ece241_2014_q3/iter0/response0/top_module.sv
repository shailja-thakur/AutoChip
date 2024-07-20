module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire ab_00, ab_01, ab_11, ab_10;
    wire c_0, c_1, d_0, d_1;
    
    assign ab_00 = ~c & ~d;
    assign ab_01 = c & ~d;
    assign ab_11 = c & d;
    assign ab_10 = ~c & d;
    
    assign c_0 = ~c;
    assign c_1 = c;
    assign d_0 = ~d;
    assign d_1 = d;
    
    assign mux_in[0] = ab_00;
    assign mux_in[1] = ab_01;
    assign mux_in[2] = ab_11;
    assign mux_in[3] = ab_10;
    
endmodule
