module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

    // Initial block to set the output to a default value of 8'h0
    initial begin
        q = 8'h0;
    end

    // Always block triggered on the rising edge of the clock input
    always @(posedge clk) begin
        // Store the data input in the register and output it on the data output
        q <= d;
    end

endmodule
