module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    parameter WL = 0; // Define state WL
    parameter WR = 1; // Define state WR

    reg state; // State register

    always @(posedge clk) begin
        if (areset) begin
            state <= WL; // Reset the state machine to WL
        end else begin
            if (state == WL) begin
                if (bump_left) begin
                    state <= WR; // Next state is WR when bump_left is high
                end else begin
                    state <= WL; // Next state is WL when bump_left is low
                end
            end else begin
                if (bump_right) begin
                    state <= WL; // Next state is WL when bump_right is high
                end else begin
                    state <= WR; // Next state is WR when bump_right is low
                end
            end
        end
    end

    assign walk_left = (state == WL) ? 1'b1 : 1'b0; // walk_left is high when state is WL
    assign walk_right = (state == WR) ? 1'b1 : 1'b0; // walk_right is high when state is WR

endmodule
