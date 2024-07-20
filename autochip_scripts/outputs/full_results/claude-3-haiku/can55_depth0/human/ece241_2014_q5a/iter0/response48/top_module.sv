module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam S0 = 1'b0, S1 = 1'b1;
reg state, next_state;
reg [7:0] num, neg_num;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= S0;
        num <= 8'd0;
        neg_num <= 8'd0;
    end
    else begin
        state <= next_state;
        num <= {num[6:0], x};
    end
end

always @(*) begin
    case (state)
        S0: begin
            if (!areset) begin
                next_state = S1;
            end
            else begin
                next_state = S0;
            end
            neg_num = 8'd0;
            z = 1'b0;
        end
        S1: begin
            if (areset) begin
                next_state = S0;
            end
            else begin
                next_state = S1;
                neg_num = ~num + 1;
                z = neg_num[0];
            end
        end
        default: begin
            next_state = S0;
            neg_num = 8'd0;
            z = 1'b0;
        end
    endcase
end

endmodule
