module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

initial begin
    q = 3'b000; // Initialize q to 0
end

always @(posedge clk) begin
    if (a == 1) begin
        q <= 3'b100; // Set q to 4 when a is 1
    end else begin
        if (q == 3'b110) begin
            q <= 3'b000; // Set q to 0 when q is 6
        end else begin
            q <= q + 1; // Increment q by 1 when it is not 6
        end
    end
end

endmodule
