module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg signed [31:0] counter;
reg signed [31:0] sum;
reg toggle;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        counter <= 0;
        sum <= 0;
        toggle <= 0;
    end
    else begin
        if (x) begin
            counter <= counter + 1;
            sum <= sum - 1;
            toggle <= 1;
        end
        else if (toggle) begin
            counter <= counter + 1;
            sum <= sum + 1;
            toggle <= 0;
        end
    end
end

assign z = sum;

endmodule
