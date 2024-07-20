module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    
    wire ab_00 = 1; // Connect ab = 00 to mux_in[0]
    wire ab_01 = 2; // Connect ab = 01 to mux_in[1]
    wire ab_11 = c; // Connect ab = 11 to mux_in[2]
    wire ab_10 = d; // Connect ab = 10 to mux_in[3]

    assign mux_in[0] = ab_00;
    assign mux_in[1] = ab_01;
    assign mux_in[2] = ab_11;
    assign mux_in[3] = ab_10;

endmodule
