module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam S0 = 1'b0, S1 = 1'b1;
reg state, next_state;
reg [7:0] reg_value;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= S0;
        reg_value <= 8'b0;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        reg_value <= {reg_value[6:0], x};
    end
end

always @(*) begin
    next_state = state;
    case (state)
        S0: begin
            if (areset) begin
                z = 1'b0;
            end
            else begin
                next_state = S1;
                z = 1'b0;
            end
        end
        S1: begin
            if (reg_value == 8'b0) begin
                z = 1'b0;
            end
            else begin
                z = ~reg_value + 1'b1;
            end
            if (areset) begin
                next_state = S0;
            end
        end
    endcase
end

endmodule
