module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);
    
    // Register to store the previous value of 'in'
    reg [7:0] d_last;

    // Always block to detect any edge on the 'in' signal
    always @(posedge clk) begin
        // Update the d_last register with the current value of 'in'
        d_last <= in;
        // Calculate anyedge by XORing the current value of 'in' and the value stored in d_last
        anyedge <= in ^ d_last;
    end

endmodule
