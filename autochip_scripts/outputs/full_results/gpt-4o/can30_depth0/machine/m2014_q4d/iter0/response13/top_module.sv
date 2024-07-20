module top_module (
    input clk,
    input in,
    output logic out
);

    // Initial value of 'out'
    initial begin
        out = 0;
    end

    // Toggle flip-flop logic
    always_ff @(posedge clk) begin
        out <= in ^ out;
    end

endmodule
