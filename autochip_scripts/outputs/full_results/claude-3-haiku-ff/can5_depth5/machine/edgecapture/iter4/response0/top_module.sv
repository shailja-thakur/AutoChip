module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

reg [31:0] d_last;

always @(posedge clk) begin
    if (reset) begin
        out <= 32'b0;
        d_last <= 32'b0;
    end
    else begin
        d_last <= in;
        if (~d_last[0] & in[0]) begin // Detect rising edge of input bit 0
            out <= out | in;
        end
    end
end

endmodule
