module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg q_temp;

always @(posedge clk) begin
    if (a & !q_temp) begin
        q_temp <= 1;
    end else if (b & q_temp) begin
        q_temp <= 0;
    end
end

always @(posedge clk) begin
    if (a) begin
        state <= 1;
    end else if (b) begin
        state <= 0;
    end
end

assign q = q_temp;
endmodule
