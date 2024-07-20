module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (a & b) begin
            q <= state;
            state <= ~state;
        end else if (a & ~b) begin
            q <= 1'b0;
            state <= 1'b0;
        end else if (~a & b) begin
            q <= 1'b1;
            state <= 1'b1;
        end else begin
            q <= state;
            state <= state;
        end
    end

endmodule
