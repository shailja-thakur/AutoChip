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

    reg [4:0] state; // State register
    reg [4:0] next_state; // Next state register
    reg [4:0] count; // Count register

    parameter WALK_LEFT = 5'b00001;
    parameter WALK_RIGHT = 5'b00010;
    parameter AAAH = 5'b00100;
    parameter DIGGING = 5'b01000;
    parameter SPLATTER = 5'b10000;

    // Output assignments
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == AAAH);
    assign digging = (state == DIGGING);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            count <= 0;
        end
        else begin
            state <= next_state;
            count <= count + 1;
        end
    end

    always @(state or bump_left or bump_right or ground or dig or count) begin
        next_state = state;
        
        case (state)
            WALK_LEFT: begin
                if (bump_left && ~bump_right)
                    next_state = WALK_RIGHT;
                else if (ground == 0)
                    next_state = AAAH;
                else if (dig && ground == 1)
                    next_state = DIGGING;
            end
            
            WALK_RIGHT: begin
                if (bump_right && ~bump_left)
                    next_state = WALK_LEFT;
                else if (ground == 0)
                    next_state = AAAH;
                else if (dig && ground == 1)
                    next_state = DIGGING;
            end
            
            AAAH: begin
                if (ground == 1 && count > 20)
                    next_state = SPLATTER;
                else if (ground == 1)
                    next_state = state;
            end
            
            DIGGING: begin
                if (ground == 0)
                    next_state = AAAH;
                else if (count > 20)
                    next_state = SPLATTER;
            end
            
            SPLATTER: begin
                // No transitions from SPLATTER state
            end
        endcase
    end
    
endmodule
