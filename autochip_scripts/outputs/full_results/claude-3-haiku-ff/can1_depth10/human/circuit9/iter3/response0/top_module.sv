module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

reg [2:0] next_q;

always @(posedge clk) begin
    q <= next_q;
end

always @(*) begin
    case (q)
        3'd0: next_q = (a) ? 3'd4 : 3'd0;
        3'd4: next_q = (a) ? 3'd4 : 3'd5;
        3'd5: next_q = (a) ? 3'd6 : 3'd0;
        3'd6: next_q = (a) ? 3'd0 : 3'd1;
        3'd1: next_q = (a) ? 3'd1 : 3'd0;
        default: next_q = 3'd0;
    endcase
end

endmodule
