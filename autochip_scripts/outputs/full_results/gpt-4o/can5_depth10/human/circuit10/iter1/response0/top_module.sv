module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (a & b) begin
            state <= 1'b0;
        end else if (a) begin
            state <= 1'b1;
        end else if (b) begin
            state <= 1'b1;
        end else begin
            state <= state;
        end
        q <= state;
    end

endmodule
