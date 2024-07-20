module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Generating the mux_in values
    // mux_in[0] represents ab = 00, so it corresponds to the c=0,d=0 combination
    assign mux_in[0] = (c & ~d) | (~c & d) | (c & d); // (0,0) is 1, (0,1) is 1, (1,0) is 1, (1,1) is 1
    
    // mux_in[1] represents ab = 01, so it corresponds to the c=0,d=1 combination
    assign mux_in[1] = 0;
    
    // mux_in[2] represents ab = 11, so it corresponds to the c=1,d=1 combination
    assign mux_in[2] = c & d;
    
    // mux_in[3] represents ab = 10, so it corresponds to the c=1,d=0 combination
    assign mux_in[3] = 1;

endmodule
