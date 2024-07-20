module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (a) begin
        if (b) begin
            state <= 1;
            q <= ~q;
        end else begin
            state <= 0;
        end
    end else begin
        if (b) begin
            q <= 1;
        end else begin
            q <= 0;
        end
    end
end

assign state = q;

endmodule
