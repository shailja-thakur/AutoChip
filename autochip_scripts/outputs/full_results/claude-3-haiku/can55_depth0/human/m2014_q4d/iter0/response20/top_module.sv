module top_module (
    input clk,
    input in,
    output logic out
);

    // Create a D flip-flop
    logic d;

    // Connect the XOR output to the D input of the flip-flop
    assign d = in ^ out;

    // Positive edge triggered D flip-flop with no reset
    always_ff @(posedge clk) begin
        out <= d;
    end

endmodule
