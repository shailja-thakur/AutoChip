module top_module(
    input clk,
    input d,
    output reg q
);

    initial begin
        q = 1'bx;  // Initialize to unknown state
    end

    always @(posedge clk) begin
        q <= d;  // Capture the input data on rising edge of clock
    end

endmodule
