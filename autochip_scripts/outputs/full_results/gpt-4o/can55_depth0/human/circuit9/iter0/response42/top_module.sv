module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    initial begin
        q = 3'b000; // Initialize q to 0
    end

    always @(posedge clk) begin
        if (a) begin
            q <= 3'b100; // Set q to 4 when a is 1
        end else if (q < 3'b110) begin
            q <= q + 1; // Increment q when a is 0 and q is less than 6
        end else begin
            q <= 3'b000; // Reset q to 0 when it reaches 6
        end
    end

endmodule
