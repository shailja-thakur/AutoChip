module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire [1:0] ab;

    // Implementing the logic for ab based on c and d inputs
    assign ab[0] = ~(c & ~d);
    assign ab[1] = d;

    // Implementing the 2-to-1 multiplexers based on ab and c inputs
    assign mux_in[0] = (ab[1] & ~ab[0]) ? 1'b0 : (ab[1] & ab[0]) ? 1'b1 : (c & d);
    assign mux_in[1] = (ab[1] & ~ab[0]) ? 1'b1 : (ab[1] & ab[0]) ? 1'b0 : (c & d);
    assign mux_in[2] = (ab[1] & ~ab[0]) ? 1'b0 : (ab[1] & ab[0]) ? 1'b0 : (c & ~d);
    assign mux_in[3] = (ab[1] & ~ab[0]) ? 1'b1 : (ab[1] & ab[0]) ? 1'b0 : (c & d);

endmodule
