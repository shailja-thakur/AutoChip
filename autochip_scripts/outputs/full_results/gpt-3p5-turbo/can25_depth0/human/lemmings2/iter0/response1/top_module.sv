module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    reg [1:0] state;
    reg [1:0] next_state;
    
    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL = 2'b10;
    
    initial begin
        state = WALK_LEFT;
        walk_left = 1;
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end
        else begin
            state <= next_state;
        end
    end
    
    always @(state or bump_left or bump_right or ground) begin
        next_state = state;
        
        case (state)
            WALK_LEFT: begin
                if (bump_right) begin
                    next_state = WALK_RIGHT;
                end
                else if (ground == 0) begin
                    next_state = FALL;
                    aaah = 1;
                end
            end
            
            WALK_RIGHT: begin
                if (bump_left) begin
                    next_state = WALK_LEFT;
                end
                else if (ground == 0) begin
                    next_state = FALL;
                    aaah = 1;
                end
            end
            
            FALL: begin
                if (ground == 1) begin
                    if (state == WALK_LEFT) begin
                        next_state = WALK_LEFT;
                    end
                    else begin
                        next_state = WALK_RIGHT;
                    end
                    aaah = 0;
                end
            end
        endcase
    end
    
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    
endmodule
