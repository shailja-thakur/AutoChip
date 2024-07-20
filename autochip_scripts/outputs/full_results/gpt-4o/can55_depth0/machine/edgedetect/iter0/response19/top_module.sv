module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    // Register to store the previous clock cycle's input value
    reg [7:0] d_last;

    always @(posedge clk) begin
        // Calculate the rising edge detection
        pedge <= in & ~d_last;
        
        // Update the register with the current input value
        d_last <= in;
    end

endmodule
