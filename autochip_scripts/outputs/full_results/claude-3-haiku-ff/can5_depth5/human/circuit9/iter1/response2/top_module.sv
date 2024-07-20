module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        if (q == 3'b100) begin
            q <= 3'b101;
        end
        else if (q == 3'b101) begin
            q <= 3'b110;
        end
        else if (q == 3'b110) begin
            q <= 3'b000;
        end
        else begin
            q <= q + 3'b001;
        end
    end
    else begin
        q <= 3'b000;
    end
end

endmodule
