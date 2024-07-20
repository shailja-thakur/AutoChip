module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] counter;
reg [7:0] complement;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        counter <= 0;
        complement <= 0;
        z <= 0;
    end
    else begin
        if (counter == 0) begin
            complement <= 0;
        end
        else begin
            complement <= complement - 1;
        end
        z <= complement[0];
        counter <= counter + 1;
    end
end

endmodule
