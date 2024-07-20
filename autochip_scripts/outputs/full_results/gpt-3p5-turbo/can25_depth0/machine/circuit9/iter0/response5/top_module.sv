module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

reg [2:0] next_q;

always@(posedge clk) begin
    if (a) begin
        next_q <= 3'b100;
    end else begin
        if (q == 3'b110) begin
            next_q <= 3'b000;
        end else begin
            next_q <= q + 1;
        end
    end
end

always@(posedge clk) begin
    q <= next_q;
end

endmodule
