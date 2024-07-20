module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

initial begin
    q = 3'b000;
end

always @(posedge clk) begin
    if (a) begin
        q <= 3'b100;
    end else begin
        if (q == 3'b100) begin
            q <= 3'b101;
        end else if (q == 3'b101) begin
            q <= 3'b110;
        end else if (q == 3'b110) begin
            q <= 3'b000;
        end else begin
            q <= q + 1;
        end
    end
end

endmodule
