module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

always @(posedge clk) begin
    if (reset) begin
        out <= 0;
    end
    else begin
        for (int i = 0; i < 32; i = i + 1) begin
            if (in[i] & ~in[i+1]) begin
                out[i] <= 1;
            end
            else begin
                out[i] <= out[i];
            end
        end
    end
end

endmodule
