module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (b) begin
            q <= state;
            state <= ~a;
        end else begin
            q <= state;
        end
    end

endmodule
