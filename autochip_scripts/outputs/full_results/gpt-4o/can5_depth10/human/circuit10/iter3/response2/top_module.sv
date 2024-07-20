module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (b) begin
            q <= ~state;
        end else begin
            q <= state;
        end
        state <= q;
    end

endmodule
