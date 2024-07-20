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
    
    reg state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            WL: begin
                if (bump_left) begin
                    next_state = WR;
                end else begin
                    next_state = WL;
                end
            end
            WR: begin
                if (bump_right) begin
                    next_state = WL;
                end else begin
                    next_state = WR;
                end
            end
            default: next_state = WL; // default state
        endcase
    end
    
    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WL;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(*) begin
        case (state)
            WL: begin
                walk_left = 1;
                walk_right = 0;
            end
            WR: begin
                walk_left = 0;
                walk_right = 1;
            end
            default: begin
                walk_left = 0;
                walk_right = 0;
            end
        endcase
    end
    
endmodule
