module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

reg [2:0] q_next;

always @(posedge clk) begin
    if (a == 0) begin
        q_next <= 0;
    end else begin
        case (q)
            0: q_next <= 4;
            4: q_next <= 4;
            5: q_next <= 5;
            6: q_next <= 0;
            default: q_next <= q;
        endcase
    end
end

always @(posedge clk) begin
    q <= q_next;
end

endmodule
