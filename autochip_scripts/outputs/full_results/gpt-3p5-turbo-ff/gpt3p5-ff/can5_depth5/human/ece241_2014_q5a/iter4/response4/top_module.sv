module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] sum;
reg [7:0] temp;

always @(posedge clk or posedge areset) begin
    if (areset)
        count <= 8'd0;
    else if (count < 8'd7)
        count <= count + 1'd1;
    else
        count <= 8'd0;
end

always @(posedge clk or posedge areset) begin
    if (areset)
        sum <= 8'd0;
    else if (count == 8'd0)
        temp <= ~x + 1;
    else
        temp <= {temp[6:0], temp[7]};
end

always @(posedge clk) begin
    if (!areset)
        z <= temp;
end

endmodule
