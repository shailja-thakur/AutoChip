module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] prev_in;
    
    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0; // Reset output
            prev_in <= 32'b0; // Reset previous input storage
        end
        else begin
            // Capture when in changes from 1 to 0
            out <= out | (prev_in & ~in);
            prev_in <= in;
        end
    end
    
endmodule
