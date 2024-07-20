module top_module (
    input c,
    input d,
    output reg [3:0] mux_in
);
    always @(*) begin
        // Compute the mux_in values based on the K-map
        mux_in[0] = (~c & ~d);  // ab = 00
        mux_in[1] = (c & ~d);   // ab = 01
        mux_in[2] = (c & d);    // ab = 11
        mux_in[3] = ~d;         // ab = 10
    end
endmodule
