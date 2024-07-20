module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    case (a)
        1'b1: begin
            if (q == 3'd4) begin
                q <= 3'd5;
            end else if (q == 3'd5) begin
                q <= 3'd6;
            end else if (q == 3'd6) begin
                q <= 3'd0;
            end else begin
                q <= q + 3'd1;
            end
        end
        1'b0: begin
            q <= 3'd0;
        end
    endcase
end

endmodule
