module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (a == 1'b1) begin
            state <= ~b;
        end
        else begin
            state <= b;
        end
        q <= state;
    end

endmodule
