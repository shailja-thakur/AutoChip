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
                if (~in[i] & in[i]) begin // Capture the 0->1 edge
                    out[i] <= 1;
                end
                else if (out[i]) begin
                    out[i] <= 0; // Reset the output to 0 if it was already set
                end
            end
        end
    end

endmodule
