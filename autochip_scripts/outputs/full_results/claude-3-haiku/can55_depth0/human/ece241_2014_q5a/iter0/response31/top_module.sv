module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] twos_complement;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        count <= 0;
        twos_complement <= 0;
        z <= 0;
    end
    else begin
        // Increment the count on every clock cycle
        count <= count + 1;

        // Compute the 2's complement
        twos_complement <= (twos_complement << 1) | x;

        // Output the 2's complement when the conversion is complete
        if (count == 8) begin
            z <= ~twos_complement + 1;
            count <= 0;
            twos_complement <= 0;
        end
        else begin
            z <= 0;
        end
    end
end

endmodule
