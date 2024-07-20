module top_module (
    input clk,
    input in,
    output reg out
);

    // Initialize the output to 0
    initial begin
        out = 0;
    end

    always @(posedge clk) begin
        out <= out ^ in;
    end

endmodule
