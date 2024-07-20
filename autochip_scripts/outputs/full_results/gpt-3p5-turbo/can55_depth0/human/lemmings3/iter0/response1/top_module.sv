module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);
    reg [1:0] state;
    
    // State assignments
    localparam IDLE = 2'b00;
    localparam WALK_LEFT = 2'b01;
    localparam WALK_RIGHT = 2'b10;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;  // Reset state to WALK_LEFT
        end else begin
            case (state)
                IDLE: begin
                    // Lemming is not walking or falling
                    if (bump_left) begin
                        state <= WALK_RIGHT;
                    end else if (bump_right) begin
                        state <= WALK_LEFT;
                    end else if (!ground) begin
                        state <= IDLE;  // Maintain IDLE state if not falling
                    end else if (dig) begin
                        state <= WALK_LEFT;
                    end
                end
                WALK_LEFT: begin
                    // Lemming is walking left
                    if (bump_right) begin
                        state <= WALK_LEFT;
                    end else if (!ground) begin
                        state <= IDLE;
                    end else if (dig) begin
                        state <= WALK_LEFT;
                    end
                end
                WALK_RIGHT: begin
                    // Lemming is walking right
                    if (bump_left) begin
                        state <= WALK_RIGHT;
                    end else if (!ground) begin
                        state <= IDLE;
                    end else if (dig) begin
                        state <= WALK_LEFT;
                    end
                end
            endcase
        end
    end
    
    // Output assignments
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (!ground && state != IDLE);
    assign digging = (state == WALK_LEFT && dig);
endmodule
