module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a == 1) begin
        q <= 3'b100; // set q to 4 when a is 1
    end
    else begin
        if (q == 3'b110) begin
            q <= 3'b000; // set q to 0 when a is 0 and q is 6
        end
        else begin
            q <= q + 1; // increase q by 1 when a is 0 and q is not 6
        end
    end
end

endmodule
