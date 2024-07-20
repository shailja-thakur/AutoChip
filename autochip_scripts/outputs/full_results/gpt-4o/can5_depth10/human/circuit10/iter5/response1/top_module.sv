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
    end

    always @(posedge clk or negedge clk) begin
        q <= state;
    end

endmodule
