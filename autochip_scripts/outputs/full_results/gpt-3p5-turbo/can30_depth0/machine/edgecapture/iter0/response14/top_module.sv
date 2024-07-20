module top_module(
    input wire clk,
    input wire reset,
    input wire [31:0] in,
    output reg [31:0] out);

    reg [31:0] d_last; // previous value of in

    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 32'b0; // initialize out to 0 when reset is asserted
        else begin
            d_last <= in; // store previous value of in

            // modify out based on the input and previous value of input
            out <= out | (~in & d_last);
        end
    end
endmodule
