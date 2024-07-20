module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 0;
        else begin
            for (integer i = 0; i < 32; i = i + 1) begin
                if (in[i] & ~in[i+1])
                    out[i] <= 1;
                else
                    out[i] <= 0;
            end
        end
    end

endmodule
