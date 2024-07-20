module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if(a == 1 && b == 1) begin
        state <= ~state;
    end else if (a == 0 && b == 1) begin
        state <= 1'b1;
    end else if (a == 1 && b == 0) begin
        state <= 1'b0;
    end
end

always @(posedge clk) begin
    q <= state;
end

endmodule
