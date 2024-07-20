module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        if (q == 4) begin
            q <= q; // Hold the value of q
        end else begin
            q <= q + 1; // Increment q
        end
    end else begin
        if (q == 0) begin
            q <= 1; // Set q to 1 when a is 0 and q is 0
        end else begin
            q <= 0; // Set q to 0 when a is 0
        end
    end
end

endmodule
