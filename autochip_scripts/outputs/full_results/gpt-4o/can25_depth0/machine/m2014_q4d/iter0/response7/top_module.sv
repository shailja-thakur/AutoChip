module top_module (
    input clk,
    input in,
    output reg out
);

    // Initialize the output signal to 0
    initial begin
        out = 0;
    end

    // Always block triggered on the positive edge of the clock signal
    always @(posedge clk) begin
        out <= out ^ in;
    end

endmodule
