module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);
    reg [7:0] in_d;

    always @(posedge clk) begin
        // Detect rising edge for each bit and store result in pedge
        pedge <= (~in_d & in);
        
        // Register previous state of in
        in_d <= in;
    end
endmodule
