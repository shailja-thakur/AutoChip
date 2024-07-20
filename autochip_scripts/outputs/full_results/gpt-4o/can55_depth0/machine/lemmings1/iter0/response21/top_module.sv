module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);
    // State encoding
    parameter WL = 1'b0, WR = 1'b1;
    
    reg state, next_state;

    // State transition on clock edge or asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= WL;
        else 
            state <= next_state;
    end

    // State transition logic
    always @(*) begin
        case (state)
            WL: begin
                if (bump_left)
                    next_state = WR;
                else
                    next_state = WL;
            end
            WR: begin
                if (bump_right)
                    next_state = WL;
                else
                    next_state = WR;
            end
            default: next_state = WL;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1;
            walk_right <= 0;
        end else begin
            case (state)
                WL: begin
                    walk_left <= 1;
                    walk_right <= 0;
                end
                WR: begin
                    walk_left <= 0;
                    walk_right <= 1;
                end
            endcase
        end
    end
endmodule
