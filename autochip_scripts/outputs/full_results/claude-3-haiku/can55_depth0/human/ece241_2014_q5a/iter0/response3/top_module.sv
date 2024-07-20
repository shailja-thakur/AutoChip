module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] complement;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        count <= 0;
        complement <= 0;
        z <= 0;
    end
    else begin
        if (count == 0) begin
            complement <= 0;
        end
        else begin
            complement <= complement + 1;
        end
        if (count == 255) begin
            z <= ~complement[7];
        end
        else begin
            z <= complement[count];
        end
        count <= count + 1;
    end
end

endmodule
