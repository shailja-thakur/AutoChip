module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

    // Initialize output to 0
    initial begin
        q = 8'h00;
    end

    // On the rising edge of the clock, store input data into the register
    always @(posedge clk) begin
        q <= d;
    end

endmodule
