module top_module (
    input clk,
    input x,
    output z
);

    reg [2:0] q; // Register to hold the D flip-flop outputs
    wire [2:0] d; // Wires for D flip-flop inputs

    // D flip-flops
    always @(posedge clk) begin
        q[0] <= d[0];
        q[1] <= d[1];
        q[2] <= d[2];
    end

    // Gates
    assign d[0] = x ^ q[0]; // XOR gate
    assign d[1] = x & ~q[1]; // AND gate with complemented flip-flop output
    assign d[2] = x | ~q[2]; // OR gate with complemented flip-flop output

    // Three-input XNOR gate
    assign z = ~(q[0] ^ q[1] ^ q[2]);

endmodule
