module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

reg [31:0] d_last; // Register to store the previous value of 'in'

// Sequential logic to capture the input and update the output
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // On reset, initialize output and d_last
        out <= 0;
        d_last <= 0;
    end else begin
        // Update the output and d_last as per the described logic
        out <= out | (~in & d_last);
        d_last <= in;
    end
end

endmodule
