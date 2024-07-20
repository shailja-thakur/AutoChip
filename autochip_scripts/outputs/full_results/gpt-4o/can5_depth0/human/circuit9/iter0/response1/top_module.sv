module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a) begin
            q <= 3'b100; // When a is high, q is set to 4
        end else begin
            q <= q + 3'b001; // When a is low, q increments by 1 modulo 8
            if (q == 3'b110) // Check if q is 6
                q <= 3'b000; // Reset q to 0 if it was 6
        end
    end

endmodule
