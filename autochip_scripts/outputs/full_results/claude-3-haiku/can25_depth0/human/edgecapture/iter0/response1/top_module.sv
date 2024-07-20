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
        for (int i = 0; i < 32; i++) begin
            if (in[i] & ~in[i+1]) begin // Detect transition from 1 to 0
                out[i] <= 1; // Set output bit to 1
            end
        end
    end
end

endmodule
