module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a) begin
            q <= 3'b100; // When a is high, q is set to 4.
        end else begin
            q <= q + 1; // When a is low, q increments by 1.
        end
            
        if (q == 3'b110) begin
            q <= 3'b000; // When q reaches 6, it resets to 0.
        end
    end

endmodule
