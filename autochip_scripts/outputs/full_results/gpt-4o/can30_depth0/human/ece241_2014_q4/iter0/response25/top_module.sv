module top_module (
    input clk,
    input x,
    output reg z
);

    reg dff1, dff2, dff3;

    wire xor_input, and_input, or_input;
    wire xor_output, and_output, or_output;

    // XOR gate with flip-flop output
    assign xor_input = dff1;
    assign xor_output = x ^ xor_input;

    // AND gate with complemented flip-flop output
    assign and_input = ~dff2;
    assign and_output = x & and_input;

    // OR gate with complemented flip-flop output
    assign or_input = ~dff3;
    assign or_output = x | or_input;

    // D flip-flops capturing the results
    always @(posedge clk) begin
        dff1 <= xor_output;
        dff2 <= and_output;
        dff3 <= or_output;
    end

    // XNOR gate for outputs of flip-flops
    always @(*) begin
        z = ~(dff1 ^ dff2 ^ dff3);
    end

endmodule
