module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    initial begin
        q = 3'b000;
    end

    always @(posedge clk) begin
        if (a == 1'b1) begin
            q <= 3'b100; // Set q to 4 when a is 1
        end else if (a == 1'b0) begin
            if (q == 3'b110) begin
                q <= 3'b000; // Set q to 0 when it's 6
            end else begin
                q <= q + 1; // Increment q by 1
            end
        end
    end

endmodule
