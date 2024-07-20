module top_module(
    input clk,
    input reset,
    output reg [9:0] q
);

reg [9:0] count;

always @(posedge clk) begin
    if (reset) begin
        count <= 0;
        q <= 0;
    end
    else if (count == 999) begin
        count <= 0;
        q <= 0;
    end
    else begin
        count <= count + 1;
        q <= count;
    end
end

endmodule
