module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Complement of inputs
    wire not_c, not_d;
    assign not_c = ~c;
    assign not_d = ~d;

    // Assign outputs based on K-map
    assign mux_in[0] = c | (~c & ~d); // Row 00 
    assign mux_in[1] = 0;             // Row 01 
    assign mux_in[2] = (~c | d);      // Row 11 
    assign mux_in[3] = 1;             // Row 10 

endmodule
