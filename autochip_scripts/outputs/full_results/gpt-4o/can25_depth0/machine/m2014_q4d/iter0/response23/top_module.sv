module top_module (
    input clk,
    input in,
    output logic out
);
    // Initialize the output signal to 0
    initial out = 0;

    // Always block that triggers on the positive edge of the clock signal
    always @(posedge clk) begin
        // Update the output signal to the XOR of the input signal and the current output signal
        out <= in ^ out;
    end
endmodule
