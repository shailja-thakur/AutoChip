module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        if (q == 3'b100) begin
            q <= 3'b100;
        end else begin
            q <= q + 1;
        end
    end else begin
        if (q == 3'b000) begin
            q <= 3'b001;
        end else if (q == 3'b101) begin
            q <= 3'b000;
        end else begin
            q <= q;
        end
    end
end

endmodule
