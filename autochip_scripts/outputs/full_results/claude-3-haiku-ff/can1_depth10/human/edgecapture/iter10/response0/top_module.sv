module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

reg [31:0] in_prev;

always @(posedge clk) begin
    if (reset) begin
        out <= 32'b0;
        in_prev <= 32'b0;
    end
    else begin
        in_prev <= in;
        for (int i = 0; i < 32; i++) begin
            if (in[i] && !in_prev[i]) begin
                out[i] <= 1'b1;
            end
            else if (out[i] && ~in[i]) begin
                out[i] <= 1'b0;
            end
        end
    end
end

endmodule
