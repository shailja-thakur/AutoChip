module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg [7:0] q,
    output reg Z
);

always @(posedge clk) begin
    if (enable) begin
        q <= q << 1;
        q[0] <= S;
    end
    if (A) begin
        Z <= q[0];
    end
    if (B) begin
        Z <= q[1];
    end
    if (C) begin
        Z <= q[2];
    end
end

endmodule
