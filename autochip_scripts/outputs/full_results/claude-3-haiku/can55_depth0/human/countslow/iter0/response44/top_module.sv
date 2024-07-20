module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

always @ (posedge clk) begin
    if (reset) begin
        q <= 4'b0;
    end
    else if (slowena) begin
        if (q == 4'd9) begin
            q <= 4'b0;
        end
        else begin
            q <= q + 1'b1;
        end
    end
end

endmodule
