module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Intermediate wires for the 2-to-1 multiplexers
    wire w0, w1, w2, w3;

    // Karnaugh map entries based on c and d
    // mux_in[0] = F(c_d) where c_d = 00, F(c_d) = 0
    // mux_in[1] = F(c_d) where c_d = 01, F(c_d) = d'
    // mux_in[2] = F(c_d) where c_d = 11, F(c_d) = 1
    // mux_in[3] = F(c_d) where c_d = 10, F(c_d) = c + d'
    
    assign w0 = 1'b0; // Value for c_d = 00
    assign w1 = ~d;   // Value for c_d = 01
    assign w2 = 1'b1; // Value for c_d = 11
    assign w3 = c | ~d; // Value for c_d = 10

    // Connecting the intermediate wires to mux_in outputs
    assign mux_in[0] = w0;
    assign mux_in[1] = w1;
    assign mux_in[2] = w2;
    assign mux_in[3] = w3;

endmodule
