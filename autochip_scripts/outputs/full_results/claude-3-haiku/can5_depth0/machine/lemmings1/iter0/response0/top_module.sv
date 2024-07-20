module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    parameter WL = 0, WR = 1;
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            WL: begin
                if (bump_left) next_state = WR;
                else next_state = WL;
            end
            WR: begin
                if (bump_right) next_state = WL;
                else next_state = WR;
            end
            default: next_state = WL;
        endcase
    end

    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset) state <= WL;
        else state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            WL: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            WR: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
            default: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule
