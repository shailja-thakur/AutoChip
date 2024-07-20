module top_module (
    input clk,
    input in,
    output logic out
);
    // Initialize the output signal to 0
    initial begin
        out = 0;
    end

    // Always block triggered on the rising edge of the clock signal
    always @(posedge clk) begin
        out <= out ^ in; // Toggle the output signal based on the input signal
    end
endmodule
