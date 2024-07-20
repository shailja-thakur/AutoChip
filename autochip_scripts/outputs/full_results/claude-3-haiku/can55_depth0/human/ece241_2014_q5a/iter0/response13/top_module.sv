module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count; // Enough to store a reasonable input size
reg [7:0] complement;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        count <= 0;
        complement <= 0;
        z <= 0;
    end
    else begin
        if (count == 0) begin // Reset condition
            z <= 0;
        end
        else begin
            z <= complement[0]; // Output the least significant bit of the complement
            complement <= (complement + 1) & ~(1 << (count - 1)); // Compute 2's complement
            count <= count - 1; // Decrement the bit count
        end
        if (x) begin // Shift in the new bit
            complement <= (complement << 1) | 1;
            count <= count + 1;
        end
    end
end

endmodule
