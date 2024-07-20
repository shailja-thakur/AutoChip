module top_module (
    input clk,
    input x,
    output z
);

    reg dff1, dff2, dff3;

    // Flip-flop assignments
    always @(posedge clk) begin
        dff1 <= x ^ dff1;
        dff2 <= x & ~dff2;
        dff3 <= x | ~dff3;
    end

    // XNOR gate to compute output z
    assign z = ~(dff1 ^ dff2 ^ dff3);

endmodule
