module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] d_last; // register to store previous value of input signal

    always @(posedge clk) begin // triggered on rising edge of clock signal
        d_last <= in; // store current value of input signal in d_last register
        pedge <= in & ~d_last; // calculate output signal pedge
    end

endmodule
