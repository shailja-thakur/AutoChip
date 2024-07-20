module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

reg [3:0] d;
reg [3:0] q;

always @(posedge clk) begin
    if (!resetn)
        q <= 4'b0;
    else begin
        q[0] <= d[0];
        q[1] <= d[1];
        q[2] <= d[2];
        q[3] <= d[3];
    end
end

always @(posedge clk) begin
    if (!resetn)
        d <= 4'b0;
    else begin
        d[0] <= in;
        d[1] <= q[0];
        d[2] <= q[1];
        d[3] <= q[2];
    end
end

assign out = q[3];

endmodule
