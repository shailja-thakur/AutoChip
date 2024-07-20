module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0000; // Asynchronous reset sets the register to 0
        end else if (load) begin
            q <= data; // Load the 4-bit data into the register
        end else if (ena) begin
            q <= q << 1; // Shift the register left by 1 bit
        end
    end
endmodule
