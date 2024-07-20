module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a && q == 3'd4) begin
        q <= 3'd5;
    end
    else if (a && q == 3'd5) begin
        q <= 3'd6;
    end
    else if (a && q == 3'd6) begin
        q <= 3'd0;
    end
    else if (a) begin
        q <= q + 3'd1;
    end
    else begin
        q <= 3'd0;
    end
end

endmodule
