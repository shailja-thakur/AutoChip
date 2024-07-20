module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
); 

    reg [4:0] state;
    reg [4:0] next_state;
    
    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL = 2'b10;
    parameter DIG = 2'b11;
    parameter SPLATTER = 2'b100;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end
        else begin
            state <= next_state;
        end
    end
    
    always @* begin
        case (state)
            WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
                
                if (bump_right && !bump_left) begin
                    next_state = WALK_RIGHT;
                end
                else if (!ground) begin
                    next_state = FALL;
                end
                else if (dig && ground) begin
                    next_state = DIG;
                end
                else if (state == SPLATTER) begin
                    next_state = WALK_LEFT;
                end
                else begin
                    next_state = WALK_LEFT;
                end
            end
            
            WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
                
                if (!bump_right && bump_left) begin
                    next_state = WALK_LEFT;
                end
                else if (!ground) begin
                    next_state = FALL;
                end
                else if (dig && ground) begin
                    next_state = DIG;
                end
                else if (state == SPLATTER) begin
                    next_state = WALK_LEFT;
                end
                else begin
                    next_state = WALK_RIGHT;
                end
            end
            
            FALL: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
                
                if (ground) begin
                    next_state = state;
                end
                else if (state == SPLATTER) begin
                    next_state = WALK_LEFT;
                end
                else begin
                    next_state = FALL;
                end
            end
            
            DIG: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
                
                if (!ground) begin
                    next_state = FALL;
                end
                else if (state == SPLATTER) begin
                    next_state = WALK_LEFT;
                end
                else begin
                    next_state = DIG;
                end
            end
            
            SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end
    
    always @(negedge clk) begin
        if (state != SPLATTER && (state == FALL && ground)) begin
            if (next_state == FALL && ground) begin
                next_state = SPLATTER;
            end
            else if (next_state != FALL) begin
                next_state = SPLATTER;
            end
        end
    end
    
endmodule
