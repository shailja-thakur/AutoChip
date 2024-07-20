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
            state <= ~state;
        end else begin
            state <= 1;
        end
    end else begin
        state <= 0;
    end
    q <= state;
end

endmodule
