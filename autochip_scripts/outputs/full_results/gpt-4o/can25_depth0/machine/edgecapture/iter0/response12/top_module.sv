module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

reg [31:0] d_last;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        out <= 32'b0;     // Output is 0 when reset is asserted
        d_last <= 32'b0;  // Initialize d_last to 0 when reset is asserted
    end else begin
        d_last <= in;          // Store current input value in d_last
        out <= out | (~in & d_last); // Modify output as specified
    end
end

endmodule
