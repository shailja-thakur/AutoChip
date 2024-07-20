module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] d_last = 0; // Signal to store previous value of in

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 0; // Resetting output value to 0
            d_last <= 0; // Resetting d_last value to 0
        end else begin
            out <= out | (~in & d_last); // Modify out value as specified
            d_last <= in; // Store current value of in in d_last
        end
    end

endmodule
