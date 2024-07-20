module top_module (
    input clk,
    input in,
    output logic out
);
    // Initialize the output signal
    initial begin
        out = 0;
    end

    // Toggle flip-flop on the positive edge of the clock signal
    always_ff @(posedge clk) begin
        out <= in ^ out;
    end
endmodule
