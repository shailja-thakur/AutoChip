module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Parameters for the state machine
    parameter WL = 1'b0; // Walk Left
    parameter WR = 1'b1; // Walk Right

    // State register
    reg state;

    // State machine logic
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= WL;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
        end else begin
            case (state)
                WL: begin
                    if (bump_left) begin
                        state <= WR;
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                    end else begin
                        state <= WL;
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                    end
                end
                WR: begin
                    if (bump_right) begin
                        state <= WL;
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                    end else begin
                        state <= WR;
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                    end
                end
                default: begin
                    state <= WL;
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
            endcase
        end
    end

endmodule
