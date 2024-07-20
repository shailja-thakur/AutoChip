module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (a & !b) begin
            q <= state;
        end else if (!a & b) begin
            q <= ~state;
        end else if (a & b) begin
            q <= 0;
        end

        state <= q;
    end

endmodule
