module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam S0 = 1'b0, S1 = 1'b1;
reg state, next_state;
reg [31:0] num, neg_num;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= S0;
        num <= 32'b0;
        z <= 1'b0;
    end else begin
        state <= next_state;
        num <= {num[30:0], x};
    end
end

always @(*) begin
    next_state = state;
    case (state)
        S0: begin
            if (~areset) begin
                next_state = S1;
                neg_num = ~num + 1'b1;
            end
        end
        S1: begin
            z = neg_num[0];
            neg_num = {neg_num[30:0], 1'b0};
        end
    endcase
end

endmodule
