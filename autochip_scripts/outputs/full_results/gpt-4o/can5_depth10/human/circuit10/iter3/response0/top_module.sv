module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (a && b) begin
            state <= ~state;
            q <= state;
        end else if (b) begin
            q <= 1;
            state <= 1;
        end else if (a) begin
            q <= 0;
            state <= 0;
        end else begin
            q <= state;
        end
    end

endmodule
