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
        if (count < 8) begin
            count <= count + 1;
            complement <= (complement >> 1) | (x << 7);
            z <= ~complement[0];
        end
        else begin
            count <= 0;
            complement <= 0;
            z <= 1; // Output the final 2's complement bit
        end
    end
end

endmodule
