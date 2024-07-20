module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

    initial begin
        q = 8'h0; // Set initial output value to 0
    end

    always @(posedge clk) begin
        q <= d; // Store the input data in the register and update the output
    end

endmodule
