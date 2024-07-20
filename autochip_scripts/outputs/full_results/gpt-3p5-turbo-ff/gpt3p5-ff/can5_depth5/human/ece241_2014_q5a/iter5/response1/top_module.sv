module top_module (
    input clk,
    input areset,
    input x,
    output reg [7:0] z
);

reg [7:0] count;
reg [8:0] sum;

always @(posedge clk or posedge areset) begin
    if (areset)
        count <= 7'b0;
    else if (count < 7'b111)
        count <= count + 1'b1;
    else
        count <= 7'b0;
end

always @(posedge clk or posedge areset) begin
    if (areset)
        sum <= 9'b0;
    else if (count == 7'b000)
        sum <= {1'b0, ~x} + 1'b1;
    else
        sum <= {1'b0, sum[7:1]};
end

always @(posedge clk or posedge areset) begin
    if (areset)
        z <= 8'b0;
    else if (count == 7'b111)
        z <= sum[7:0];
end

endmodule
