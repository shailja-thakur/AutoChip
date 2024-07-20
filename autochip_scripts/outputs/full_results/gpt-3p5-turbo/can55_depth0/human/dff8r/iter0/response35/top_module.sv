module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    reg [7:0] d_ff [7:0];

    always @(posedge clk) begin
        if (reset)
            q <= 8'b0;
        else begin
            for (integer i = 0; i < 8; i = i + 1) begin
                d_ff[i] <= d[i];
            end
            q <= d_ff;
        end
    end

endmodule
