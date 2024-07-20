module top_module (
    input clk,
    input x,
    output z
);

    reg dff1, dff2, dff3;
    wire xor_out, and_out, or_out;
    wire xn1, xn2, xn3;

    // XOR gate
    assign xor_out = x ^ dff1;
    
    // AND gate
    assign and_out = x & ~dff2;
    
    // OR gate
    assign or_out = x | ~dff3;
    
    // DFF assignments
    always @(posedge clk) begin
        dff1 <= xor_out;
        dff2 <= and_out;
        dff3 <= or_out;
    end

    // 3-input XNOR gate
    assign z = ~(dff1 ^ dff2 ^ dff3);

endmodule
