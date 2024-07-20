module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (a == 1'b1 && b == 1'b1) begin
            state <= 1'b0;
        end else if (a == 1'b1) begin
            state <= 1'b1;
        end else if (b == 1'b1) begin
            state <= 1'b1;
        end else begin
            state <= state;
        end
        q <= state;
    end

endmodule
