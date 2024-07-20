module top_module (
    input clk,
    input a,
    output reg [2:0] q
);
    // Initial state
    initial q = 3'bxxx;

    always @(posedge clk) begin
        if (a == 1) begin
            q <= 3'b100; // When 'a' is 1, 'q' is set to 4
        end else begin
            // When 'a' is 0, 'q' is incremented by 1 each clock cycle
            // until 6 and then goes back to 0 and continues counting
            if (q == 3'b110) begin
                q <= 3'b000;
            end else begin
                q <= q + 1;
            end
        end
    end
endmodule
