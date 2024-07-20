module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] result;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        count <= 0;
        result <= 0;
        z <= 0;
    end
    else begin
        count <= count + 1;
        result[count] <= x;
        if (count == 7) begin
            result = ~result + 1;
            z <= result[0];
            count <= 0;
        end
    end
end

endmodule
