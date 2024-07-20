module top_module(
    input c,
    input d,
    output [3:0] mux_in
);

    wire nand1, nand2, mux1_out, mux2_out;

    // Implement the Karnaugh map using multiplexers
    assign nand1 = ~(c & d);
    assign nand2 = ~(~c & d);
    assign mux1_out = (c) ? 1'b0 : nand1;
    assign mux2_out = (d) ? nand2 : 1'b1;
    assign mux_in = {mux2_out, 1'b0, mux1_out, 1'b1};

endmodule
