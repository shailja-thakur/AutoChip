module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a) begin
            q <= 4; // When 'a' is 1, 'q' is 4
        end else begin
            if (q == 4 || q == 5 || q == 6) begin
                q <= q + 1; // Increment when 'q' is 4, 5, or 6
            end else begin
                q <= q + 1; // Start from 0 when 'q' is not 4, 5, or 6
            end
        end
    end

endmodule
