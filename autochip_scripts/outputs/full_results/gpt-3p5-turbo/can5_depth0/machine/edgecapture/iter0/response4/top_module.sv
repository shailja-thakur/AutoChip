module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] d_last; // Signal to store the previous value of in

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 32'b0; // Set the output to 0 initially when reset is asserted
        end else begin
            d_last <= in; // Store the previous value of in
            out <= out | (~in & d_last); // Modify the output value
        end
    end

endmodule
