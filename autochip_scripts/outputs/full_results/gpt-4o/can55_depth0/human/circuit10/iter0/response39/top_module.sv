module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (a == 1) begin
        if (b == 1) begin
            state <= ~state;
            q <= state;
        end else begin
            state <= state;
            q <= state;
        end
    end else begin
        if (b == 1) begin
            state <= state;
            q <= ~state;
        end else begin
            state <= state;
            q <= state;
        end
    end
end

endmodule
