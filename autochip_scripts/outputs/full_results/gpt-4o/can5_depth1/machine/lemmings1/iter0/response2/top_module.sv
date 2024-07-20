module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State encoding
    parameter WL = 1'b0;
    parameter WR = 1'b1;

    // Current state register
    reg state;

    // Combinational next state logic
    always @(*) begin
        case (state)
            WL: begin
                if (bump_left)
                    state = WR;
                else
                    state = WL;
            end
            WR: begin
                if (bump_right)
                    state = WL;
                else
                    state = WR;
            end
        endcase
    end

    // Sequential state update on rising edge of clk or areset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WL;
        end
        else begin
            case (state)
                WL: begin
                    if (bump_left)
                        state <= WR;
                    else
                        state <= WL;
                end
                WR: begin
                    if (bump_right)
                        state <= WL;
                    else
                        state <= WR;
                end
            endcase
        end
    end

    // Output logic based on current state
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
