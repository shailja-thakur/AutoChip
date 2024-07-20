module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] sum;
reg out_ready;

always @(posedge clk) begin
    if (areset)
        count <= 8'd0;
    else if (out_ready)
        count <= count + 1'd1;
    else
        count <= 8'd0;
end

always @(posedge clk) begin
    if (areset)
        sum <= 8'd0;
    else if (count == 8'd0)
        sum <= ~x + 1;
    else
        sum <= {sum[6:0], sum[7]};
end

always @(posedge clk) begin
    if (areset)
        out_ready <= 1'b0;
    else if (count == 8'd7)
        out_ready <= 1'b1;
    else
        out_ready <= 1'b0;
end

always @(posedge clk) begin
    if (areset)
        z <= 1'b0;
    else if (out_ready)
        z <= sum;
    else
        z <= 1'b0;
end

endmodule
