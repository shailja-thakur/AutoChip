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

    // Combinational logic
    wire xor_out, and_out, or_out;
    assign xor_out = x ^ state[0];
    assign and_out = x & ~state[0];
    assign or_out = x | ~state[0];

    assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
