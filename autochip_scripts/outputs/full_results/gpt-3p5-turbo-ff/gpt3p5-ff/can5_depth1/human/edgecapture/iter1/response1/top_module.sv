module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);
    
    reg [31:0] prev_in;
    reg [31:0] prev_out; // Added: to capture the previous value of out
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            prev_in <= 32'b0;
        else
            prev_in <= in;
    end

    always @(posedge clk) begin
        prev_out <= out; // Added: to capture the previous value of out
        out <= prev_in & ~in;
    end

    always @(posedge clk) begin
        if (reset)
            out <= 32'b0; // Modified: output is reset to 0
        else if (out ^ prev_out)
            out <= 32'b1; // Modified: output remains 1 only for the cycle when there is a transition from 1 to 0
        else
            out <= 32'b0;
    end

endmodule
