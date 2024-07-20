module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a == 1) begin
            q <= 4; // When 'a' is 1, output 'q' is set to 4
        end else begin
            q <= q + 1; // When 'a' is 0, output 'q' increments
            if (q == 6) begin
                q <= 0; // Reset 'q' to 0 after it reaches 6
            end
        end
    end

endmodule
