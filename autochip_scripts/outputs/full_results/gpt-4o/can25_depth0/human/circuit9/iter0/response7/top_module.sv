module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a == 1) begin
            q <= 3'b100;  // q is set to 4 (binary 100) when a is 1
        end else begin
            if (q == 3'b110) begin
                q <= 3'b000;  // When q reaches 6, reset to 0
            end else begin
                q <= q + 1;  // Increment q otherwise
            end
        end
    end

endmodule
