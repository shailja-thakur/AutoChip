module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a) begin
            q <= 3'd4;  // When 'a' is high, set q to 4
        end else begin
            q <= q + 3'd1;  // When 'a' is low, increment q by 1
        end

        // Reset q to 0 when it reaches 7 (3'd7)
        if (q == 3'd7) begin
            q <= 3'd0;
        end
    end

endmodule
