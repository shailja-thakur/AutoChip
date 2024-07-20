module top_module(
    input clk,
    input d,
    output reg q
);
    
    // Initialize q to an unknown or undefined value
    initial begin
        q = 1'bx;
    end

    // Synchronize data signal d with clock signal clk
    always @(posedge clk) begin
        q <= d;
    end

endmodule
