module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] counter;
reg [7:0] two_complement;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        counter <= 0;
        two_complement <= 0;
        z <= 0;
    end
    else begin
        if (counter == 0) begin
            two_complement <= 0;
            z <= 0;
        end
        else begin
            two_complement[counter-1] <= ~x;
            z <= two_complement[counter-1];
            counter <= counter - 1;
        end
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        counter <= 8'b11111111;
    end
    else begin
        if (counter != 0) begin
            counter <= counter - 1;
        end
    end
end

endmodule
