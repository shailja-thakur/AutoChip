module top_module (
    input clk,
    input x,
    output z
);
    reg dff1, dff2, dff3; // D flip-flops

    // Next state logic for flip-flops
    wire xor_next, and_next, or_next;

    assign xor_next = x ^ dff1;
    assign and_next = x & ~dff2;
    assign or_next  = x | ~dff3;

    // D flip-flops with clk
    always @(posedge clk) begin
        dff1 <= xor_next;
        dff2 <= and_next;
        dff3 <= or_next;
    end

    // Output logic
    assign z = ~(dff1 ~^ dff2 ~^ dff3);

endmodule
