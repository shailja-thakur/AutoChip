module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] counter;
reg [7:0] sum;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        counter <= 0;
        sum <= 0;
    end else begin
        if (counter == 0) begin
            z <= ~x;
            sum <= x;
            counter <= counter + 1;
        end else begin
            z <= ~sum + 1;
            sum <= sum + x;
            counter <= counter + 1;
        end
    end
end

endmodule
