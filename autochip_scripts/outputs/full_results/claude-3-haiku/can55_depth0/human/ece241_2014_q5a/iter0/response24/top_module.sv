module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] counter;
reg [7:0] temp;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        counter <= 0;
        temp <= 0;
        z <= 0;
    end
    else begin
        if (counter == 0) begin
            temp <= 0;
        end
        else begin
            temp[counter-1] <= x;
        end
        counter <= counter + 1;
        if (counter == 8) begin
            z <= ~temp + 1;
            counter <= 0;
        end
        else begin
            z <= 0;
        end
    end
end

endmodule
