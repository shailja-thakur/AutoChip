module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q);

    reg [7:0] d_ff [0:7];
    integer i;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            for (i = 0; i < 8; i = i + 1) begin
                d_ff[i] <= 0;
            end
        end else begin
            for (i = 0; i < 8; i = i + 1) begin
                d_ff[i] <= d[i];
            end
        end
    end

    always @(posedge clk) begin
        if (!areset) begin
            for (i = 0; i < 8; i = i + 1) begin
                q[i] <= d_ff[i];
            end
        end
    end

endmodule
