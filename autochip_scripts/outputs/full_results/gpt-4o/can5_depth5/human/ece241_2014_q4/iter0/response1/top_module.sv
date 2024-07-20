module top_module (
    input clk,
    input x,
    output reg z
);
    reg dff1, dff2, dff3;
    wire xor_out, and_out, or_out;
    wire dff2_bar, dff3_bar;

    // Generate complemented outputs of D flip-flops
    assign dff2_bar = ~dff2;
    assign dff3_bar = ~dff3;

    // Gates
    assign xor_out = x ^ dff1;
    assign and_out = x & dff2_bar;
    assign or_out = x | dff3_bar;

    // D flip-flops
    always @(posedge clk) begin
        dff1 <= xor_out;
        dff2 <= and_out;
        dff3 <= or_out;
    end

    // 3-input XNOR gate
    always @* begin
        z = ~(dff1 ^ dff2 ^ dff3);
    end

endmodule
