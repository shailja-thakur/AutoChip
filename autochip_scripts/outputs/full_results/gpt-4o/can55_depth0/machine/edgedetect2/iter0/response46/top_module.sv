module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] d_last;

    // Initial block to set the initial value of d_last to 0.
    initial begin
        d_last = 8'b0;
    end

    // Always block to detect any edge on the in signal.
    always @(posedge clk) begin
        anyedge <= in ^ d_last;  // XOR operation to detect edges.
        d_last <= in;            // Update d_last with current in value.
    end

endmodule
