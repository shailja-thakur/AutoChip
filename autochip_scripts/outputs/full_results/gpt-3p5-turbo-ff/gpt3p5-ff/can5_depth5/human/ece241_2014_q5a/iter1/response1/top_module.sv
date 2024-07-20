module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] sum;

initial begin
    count <= 8'd0;
    sum <= 8'd0;
    z <= 1'b0;
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        count <= 8'd0;
        sum <= 8'd0;
    end else if (count == 8'd7) begin
        count <= 8'd0;
        sum <= ~x + 1;
    end else begin
        count <= count + 1;
        sum <= {sum[6:0], sum[7]};
    end
end

assign z = sum;

endmodule
