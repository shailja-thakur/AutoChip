module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 0;
        else begin
            // Check for rising edge
            out <= out | (in & ~previous_in);
        end
        previous_in <= in;
    end

endmodule
