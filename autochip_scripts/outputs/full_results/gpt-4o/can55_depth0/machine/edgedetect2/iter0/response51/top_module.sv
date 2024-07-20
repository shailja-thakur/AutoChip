module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] d_last;

    // Always block triggered on the rising edge of the clock signal
    always @(posedge clk) begin
        // Update the d_last register with the current value of in
        d_last <= in;
        // Calculate anyedge by performing XOR between current in and d_last
        anyedge <= in ^ d_last;
    end

endmodule
