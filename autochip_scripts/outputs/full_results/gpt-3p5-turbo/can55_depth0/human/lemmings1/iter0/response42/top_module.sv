module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg [1:0] current_state;
    reg [1:0] next_state;
    
    // State encoding: 00 - Walking left, 01 - Walking right
    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    
    // Output assignment
    assign walk_left = (current_state == WALK_LEFT);
    assign walk_right = (current_state == WALK_RIGHT);
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end
    
    always @(current_state or bump_left or bump_right) begin
        case (current_state)
            WALK_LEFT: begin
                if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (bump_left) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            
            WALK_RIGHT: begin
                if (bump_left) begin
                    next_state = WALK_LEFT;
                end else if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
        endcase
    end
    
endmodule
