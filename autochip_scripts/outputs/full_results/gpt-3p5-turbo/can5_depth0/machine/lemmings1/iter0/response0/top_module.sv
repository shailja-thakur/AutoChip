module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // States
    parameter WL = 1'b0;
    parameter WR = 1'b1;
    reg state, next_state;

    // State machine
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WL;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        if (state == WL) begin
            if (bump_left) begin
                next_state = WR;
            end else begin
                next_state = WL;
            end
        end else if (state == WR) begin
            if (bump_right) begin
                next_state = WL;
            end else begin
                next_state = WR;
            end
        end
    end
    
    // Output assignments
    always @(*) begin
        if (state == WL) begin
            walk_left = 1'b1;
            walk_right = 1'b0;
        end else begin
            walk_left = 1'b0;
            walk_right = 1'b1;
        end
    end
    
endmodule
