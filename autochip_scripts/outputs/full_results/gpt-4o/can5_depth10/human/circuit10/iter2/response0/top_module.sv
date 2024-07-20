module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (b) begin
            q <= a;
            state <= a;
        end else if (!a && !b) begin
            q <= state;
        end else if (a && !b) begin
            q <= state;
        end
    end

endmodule
