module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] complement;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        count <= 0;
        complement <= 0;
        z <= 0;
    end
    else begin
        if (count == 8'd0) begin
            complement <= 8'd0;
        end
        else begin
            complement[count-1] <= ~x;
        end
        if (count == 8'd7) begin
            complement <= complement + 1;
            z <= complement[7];
        end
        else begin
            z <= 0;
        end
        count <= count + 1;
    end
end

endmodule
