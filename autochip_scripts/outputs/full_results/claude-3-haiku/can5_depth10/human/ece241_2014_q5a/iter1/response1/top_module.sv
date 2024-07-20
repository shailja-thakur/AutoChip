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
        count <= 8'd0;
        complement <= 8'd0;
        z <= 1'b0;
    end
    else begin
        if (count < 8'd8) begin
            count <= count + 1'b1;
            complement <= (complement << 1) | x;
            z <= ~complement[7];
        end
        else begin
            count <= 8'd0;
            complement <= 8'd0;
            z <= 1'b0;
        end
    end
end

endmodule
