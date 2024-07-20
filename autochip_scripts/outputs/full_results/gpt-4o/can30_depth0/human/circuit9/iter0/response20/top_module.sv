module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a) begin
            q <= 4;    // When 'a' is high, set q to 4
        end else begin
            if (q == 6) begin
                q <= 0; // Reset q to 0 if q reaches 6
            end else begin
                q <= q + 1; // Increment q by 1
            end
        end
    end

endmodule
