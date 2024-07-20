module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Initial block to set the counter to an initial value
    initial begin
        q = 4'b0000;
    end
    
    // Always block triggered on the rising edge of clk
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;   // Reset counter to 0 if reset is asserted
        end else begin
            q <= q + 4'b0001; // Increment counter by 1
        end
    end
    
endmodule
