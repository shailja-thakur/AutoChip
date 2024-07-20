module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        state <= q; // state is the previous value of q
        if (b) begin
            q <= a;
        end else begin
            q <= state;
        end
    end

endmodule
