module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if(a) begin
        state <= b;
        q <= b;
    end
    else begin
        q <= state;
    end
end

endmodule
