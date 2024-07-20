module top_module(
    input clk,
    input reset,
    output reg [3:0] q
); 

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 4'b0000; // reset the counter to 0
    end else begin
        if (q == 4'b1001) begin
            q <= 4'b0000; // reset the counter to 0 when it reaches 9
        end else begin
            q <= q + 1; // increment the counter by 1
        end
    end
end

endmodule
