module top_module (
    input clk,
    input x,
    output z
);

    // Registers for D flip-flops
    reg dff_q1, dff_q2, dff_q3;

    // Wires for gate outputs
    wire xor_out, and_out, or_out;

    // Gates: Generate outputs based on x and the current state of the flip-flops
    assign xor_out = x ^ dff_q1;
    assign and_out = x & ~dff_q2;
    assign or_out = x | ~dff_q3;
    
    // D Flip-flops: Update their state on the positive edge of the clock
    always @(posedge clk) begin
        dff_q1 <= xor_out;
        dff_q2 <= and_out;
        dff_q3 <= or_out;
    end

    // XNOR of the outputs of the flip-flops to produce z
    assign z = ~(dff_q1 ^ dff_q2 ^ dff_q3);

endmodule
