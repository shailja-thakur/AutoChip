module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] complement;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        count <= 0;
        complement <= 0;
        z <= 0;
    end
    else begin
        // Increment the bit count
        count <= count + 1;

        // Compute the 2's complement
        complement <= complement + {7'b0, ~x};

        // Output the current bit of the 2's complement
        z <= complement[0];

        // Shift the complement to the right by 1 bit
        complement <= {1'b0, complement[7:1]};
    end
end

endmodule
