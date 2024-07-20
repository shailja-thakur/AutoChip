module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] sum;
reg [8:0] temp;
reg areset_sync;

always @(posedge clk) begin
    areset_sync <= areset;
end

always @(posedge clk or posedge areset_sync) begin
    if (areset_sync)
        count <= 8'd0;
    else if (count < 8'd7)
        count <= count + 1'd1;
    else
        count <= 8'd0;
end

always @(posedge clk or posedge areset_sync) begin
    if (areset_sync)
        sum <= 8'd0;
    else if (count == 8'd0)
        temp <= {1'b0, ~x};
    else
        temp <= {1'b0, temp[8:1]};
end

always @(posedge clk or posedge areset_sync) begin
    if (areset_sync)
        z <= 8'd0;
    else
        z <= temp[7:0] + 1'b1;
end

endmodule
