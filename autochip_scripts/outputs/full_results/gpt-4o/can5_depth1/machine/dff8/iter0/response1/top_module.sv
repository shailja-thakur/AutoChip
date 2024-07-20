module top_module (
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

    // Initialize output
    initial begin
        q = 8'h0;
    end

    // Always block to trigger on the rising edge of the clock
    always @(posedge clk) begin
        q <= d;
    end

endmodule
