module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] in_d; // Register to store previous input

always @(posedge clk) begin
    in_d <= in; // Store previous input
    anyedge <= in ^ in_d; // Detect edge using XOR
end

endmodule
