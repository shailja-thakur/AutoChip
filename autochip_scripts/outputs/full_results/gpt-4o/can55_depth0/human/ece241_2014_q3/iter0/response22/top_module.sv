module top_module (
    input c,
    input d,
    output reg [3:0] mux_in
);

    always @(*) begin
        // Assign mux_in[0] -> F(c,d) for ab = 00
        mux_in[0] = (c & ~d) | (~c & d);

        // Assign mux_in[1] -> F(c,d) for ab = 01
        mux_in[1] = 0;

        // Assign mux_in[2] -> F(c,d) for ab = 11
        mux_in[2] = c | d;

        // Assign mux_in[3] -> F(c,d) for ab = 10
        mux_in[3] = 1;
    end

endmodule
