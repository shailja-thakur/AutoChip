module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [3:0] count;
reg [7:0] complement;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        count <= 0;
        complement <= 8'b11111111;
        z <= 0;
    end
    else begin
        if (count < 8) begin
            count <= count + 1;
            complement <= (complement >> 1) | (x << 7);
            z <= ~complement[0];
        end
        else if (count == 8) begin
            count <= 0;
            complement <= ~complement + 1;
            z <= complement[0];
        end
    end
end

endmodule
