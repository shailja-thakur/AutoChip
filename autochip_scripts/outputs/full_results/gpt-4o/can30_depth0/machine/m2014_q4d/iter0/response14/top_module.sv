module top_module (
    input clk,
    input in,
    output logic out
);

    // Initialize the output to 0
    initial out = 0;

    // Toggle flip-flop behavior on clock's posedge
    always_ff @(posedge clk) begin
        out <= in ^ out;
    end

endmodule
