module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

    // Register to store the previous value of the input signal
    reg [7:0] d_last;

    // Always block to be triggered on the rising edge of the clock signal
    always @(posedge clk) begin
        // Calculate the rising edge detection
        pedge <= in & ~d_last;
        // Update the d_last register with the current input value
        d_last <= in;
    end

endmodule
