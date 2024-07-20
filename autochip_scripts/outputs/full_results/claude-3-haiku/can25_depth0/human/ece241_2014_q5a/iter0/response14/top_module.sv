module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] temp;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        count <= 0;
        temp <= 0;
        z <= 0;
    end
    else begin
        if (count < 8) begin
            temp[count] <= x;
            count <= count + 1;
        end
        else begin
            temp = ~temp + 1;
            z <= temp[count-1];
            count <= 0;
        end
    end
end

endmodule
