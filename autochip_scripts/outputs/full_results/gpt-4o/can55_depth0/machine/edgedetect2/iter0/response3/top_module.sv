module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] d_last;

    always @(posedge clk) begin
        d_last <= in; // Update d_last with the current value of in
        anyedge <= in ^ d_last; // Calculate anyedge by XORing current in and d_last
    end

endmodule
