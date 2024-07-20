module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] complement;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        count <= 0;
        complement <= 0;
        z <= 0;
    end
    else begin
        // Capture the input bits
        complement <= {complement[6:0], x};
        
        // Increment the bit counter
        count <= count + 1;
        
        // Output the 2's complement
        z <= ~complement[count] + (count == 8);
    end
end

endmodule
