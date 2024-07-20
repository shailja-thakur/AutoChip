module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

initial begin
    q = 3'b000;
end

always @(posedge clk) begin
    if (a) begin
        q <= 3'b100; // Set q to 4
    end
    else begin
        if (q == 6) begin
            q <= 3'b000; // Set q to 0 if q is 6
        end
        else begin
            q <= q + 1; // Increment q by 1
        end
    end
end

endmodule
