module top_module (
    input clk,
    input a,
    input b,
    input rst,
    output reg q,
    output reg state
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= 0;
        q <= 0;
    end else begin
        state <= a & b;
        q <= state;
    end
end

endmodule
