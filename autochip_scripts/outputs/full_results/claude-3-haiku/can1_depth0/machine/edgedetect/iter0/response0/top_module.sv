module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] d_last;

always @(posedge clk) begin
    // Store the current value of the input signal in d_last
    d_last <= in;
    
    // Calculate the rising edge detection signal
    pedge <= in & ~d_last;
end

endmodule
