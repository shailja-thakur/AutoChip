module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

reg q_next, q_reg;

always @(posedge clk) begin
    q_reg <= q_next;
end

always @(*) begin
    if (state == 0) begin
        if (a == 1 && b == 0)
            q_next = 1'b1;
        else
            q_next = 1'b0;
    end
    else begin
        if (a == 0 && b == 1)
            q_next = 1'b0;
        else
            q_next = 1'b1;
    end
end

assign q = q_reg;
assign state = q_reg;

endmodule
