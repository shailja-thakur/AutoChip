module top_module (
    input c,
    input d,
    output reg [3:0] mux_in
);

    always @(*) begin
        // Assign values to mux_in[0] to mux_in[3] based on inputs c and d
        mux_in[0] = (~c & ~d) ? 1 : 0;
        mux_in[1] = ( c & ~d) ? 1 : 0;
        mux_in[2] = ( c &  d) ? 1 : 0;
        mux_in[3] = (~c &  d) ? 1 : 0;
    end
endmodule
