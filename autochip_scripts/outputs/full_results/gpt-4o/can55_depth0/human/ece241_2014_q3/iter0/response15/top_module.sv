module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign mux_in[0] for ab = 00, which corresponds to cd = 00, 01, 11, 10
    assign mux_in[0] = (~c & ~d) ? 1'b0 : // cd = 00
                      (~c &  d) ? 1'b1 : // cd = 01
                      ( c &  d) ? 1'b1 : // cd = 11
                      ( c & ~d) ? 1'b1 : // cd = 10
                                  1'b0;
                                  
    // Assign mux_in[1] for ab = 01, which corresponds to cd = 00, 01, 11, 10
    assign mux_in[1] = 1'b0; // Always 0 based on K-map
    
    // Assign mux_in[2] for ab = 11, which corresponds to cd = 00, 01, 11, 10
    assign mux_in[2] = ( c &  d) ? 1'b1 :
                                  1'b0;
                                  
    // Assign mux_in[3] for ab = 10, which corresponds to cd = 00, 01, 11, 10
    assign mux_in[3] = (~c & ~d) ? 1'b1 : // cd = 00
                      ( c & ~d) ? 1'b1 : // cd = 10
                                  1'b0;

endmodule
