module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (a & b) begin
            state <= ~state;
        end

        if (a) begin
            q <= state;
        end else begin
            q <= b;
        end
    end

endmodule
