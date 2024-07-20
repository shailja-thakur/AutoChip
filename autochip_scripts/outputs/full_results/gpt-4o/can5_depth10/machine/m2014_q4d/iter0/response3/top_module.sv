module top_module (
    input clk,
    input in,
    output reg out
);

    // Initialize the output signal to 0
    initial out = 0;

    always @(posedge clk) begin
        out <= out ^ in;
    end

endmodule
