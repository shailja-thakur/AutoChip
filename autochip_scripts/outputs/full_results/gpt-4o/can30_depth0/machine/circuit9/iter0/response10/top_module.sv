module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    // Initial state of q
    initial q = 3'b000;

    always @(posedge clk) begin
        if (a == 1'b1) begin
            q <= 3'b100; // Set q to 4
        end
        else if (a == 1'b0) begin
            if (q == 3'b110) begin
                q <= 3'b000; // If q is 6, set q to 0
            end
            else begin
                q <= q + 1; // Otherwise, increment q by 1
            end
        end
    end

endmodule
