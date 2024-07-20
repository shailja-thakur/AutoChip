module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

always @(posedge clk) begin
    if (reset) begin
        out <= 32'b0;
    end
    else begin
        for (int i = 0; i < 32; i++) begin
            // Check if the current bit has transitioned from 1 to 0
            if (in[i] && ~in[i]) begin
                out[i] <= 1'b1;
            end
            // If the output bit is set, keep it set until reset
            else if (out[i]) begin
                out[i] <= 1'b1;
            end
            // Otherwise, clear the output bit
            else begin
                out[i] <= 1'b0;
            end
        end
    end
end

endmodule
