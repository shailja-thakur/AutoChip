module top_module (
    input c,
    input d,
    output reg [3:0] mux_in
);

    always @(*) begin
        // Define mux inputs based on the Karnaugh map
        // ab = 00 -> mux_in[0]
        // ab = 01 -> mux_in[1]
        // ab = 11 -> mux_in[3]
        // ab = 10 -> mux_in[2]
        mux_in[0] = (~c & d) | (c & ~d) | (c & d);
        mux_in[1] = 1'b0;
        mux_in[2] = (~c & d) | (c & ~d) | (c & d);
        mux_in[3] = (~c & d) | (c & ~d) | (c & d);
    end

endmodule
