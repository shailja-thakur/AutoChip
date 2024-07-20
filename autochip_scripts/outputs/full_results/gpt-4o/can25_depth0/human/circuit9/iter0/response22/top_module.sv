module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        // Check if 'a' is high or low
        if (a) begin
            // When 'a' is high, reset q to 4
            q <= 4;
        end else begin
            // When 'a' is low, increment q
            if (q == 6) begin
                // If q is 6, reset it to 0
                q <= 0;
            end else begin
                // Increment q otherwise
                q <= q + 1;
            end
        end
    end

endmodule
