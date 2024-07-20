module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] in_delayed;

    always @(posedge clk) begin
        in_delayed <= in;  // Store previous input state
        
        // Detect any edge by XORing current and previous state
        anyedge <= in ^ in_delayed;
    end

endmodule
