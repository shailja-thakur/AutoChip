module top_module (
    input clk,
    input areset,
    input x,
    output reg signed [7:0] z
);

reg [7:0] count;
reg [7:0] sum;

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
        sum <= -x;
    else if (count == 8'd0)
        sum <= -x;
    else
        sum <= sum;
end

assign z = sum;

endmodule
