module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg next_Q;
wire rst;
reg temp;

always @(posedge clk) begin
    if (L) begin
        next_Q <= R;
    end else if (E) begin
        next_Q <= temp;
    end else begin
        next_Q <= Q;
    end
end

always @(posedge clk) begin
    if (L) begin
        temp <= w;
    end else begin
        temp <= Q;
    end
end

assign rst = ~E;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        Q <= 1'b0;
    end else begin
        Q <= next_Q;
    end
end

endmodule
