module top_module (
    input clk,
    input a,
    output reg q
);

    reg state;

    always @(posedge clk) begin
        if (a == 1) begin
            state <= 1'b0;
        end else begin
            state <= 1'b1;
        end
        q <= state;
    end

endmodule
