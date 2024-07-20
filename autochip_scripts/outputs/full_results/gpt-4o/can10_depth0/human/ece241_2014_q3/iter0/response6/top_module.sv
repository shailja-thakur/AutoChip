module top_module (
    input c,
    input d,
    output reg [3:0] mux_in
);

    always @(*) begin
        // Define the working variables corresponding to the states in the K-map.
        mux_in[0] = (~c & ~d & 0) | (~c & d & 1) | (c & ~d & 1) | (c & d & 1);
        mux_in[1] = 0; // since the K-map value is 0 for all cases
        mux_in[2] = 0; // since the K-map value is 0 for all cases
        mux_in[3] = (~c & ~d & 1) | (c & ~d & 1);
    end

endmodule
