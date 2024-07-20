module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

    reg [7:0] d_last; // Register to store the previous value of the input signal

    // Always block triggered on the rising edge of the clock signal
    always @(posedge clk) begin
        d_last <= in; // Store the current value of the input signal in d_last
        pedge <= in & ~d_last; // Calculate the pedge signal to detect rising edges
    end
endmodule
