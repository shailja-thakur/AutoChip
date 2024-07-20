module top_module (
    input clk,
    input x,
    output z
);

    reg [2:0] state;

    // D flip-flops
    always @(posedge clk) begin
        state <= {state[1:0], x};
    end

    // XOR gate
    wire xor_out = x ^ state[0];

    // AND gate
    wire and_out = x & ~state[1];

    // OR gate
    wire or_out = x | state[2];

    // XNOR gate
    assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
