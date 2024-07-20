module top_module (
    input clk,
    input x,
    output z
);

    // Declare D flip-flops and their complements
    reg d1, d1_bar, d2, d2_bar, d3, d3_bar;

    // Combinational logic for D flip-flop inputs
    wire xor_out = x ^ d1;
    wire and_out = x & ~d2;
    wire or_out = x | ~d3;

    // D flip-flop updates
    always @(posedge clk) begin
        d1 <= xor_out;
        d2 <= and_out;
        d3 <= or_out;
    end

    // Combinational logic for output
    wire xnor_out = ~(d1 ^ d2 ^ d3);
    assign z = xnor_out;

endmodule
