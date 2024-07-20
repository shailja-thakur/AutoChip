module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

// Define states
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;

// Define state register and next state
reg [1:0] state;
reg [1:0] next_state;

// Define outputs
reg walk_left;
reg walk_right;
reg aaah;

// Synchronous reset
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

// Next state and output logic
always @(*)
begin
    case(state)
        WALK_LEFT:
            begin
                if(ground == 0) // If ground disappears
                    begin
                        next_state = FALL;
                        aaah = 1;
                    end
                else
                    begin
                        if(bump_right == 1) // If bumped on the right
                            next_state = WALK_RIGHT;
                        else
                            next_state = WALK_LEFT;
                            
                        aaah = 0;
                    end
                walk_left = 1;
                walk_right = 0;
            end
        WALK_RIGHT:
            begin
                if(ground == 0) // If ground disappears
                    begin
                        next_state = FALL;
                        aaah = 1;
                    end
                else
                    begin
                        if(bump_left == 1) // If bumped on the left
                            next_state = WALK_LEFT;
                        else
                            next_state = WALK_RIGHT;
                            
                        aaah = 0;
                    end
                walk_left = 0;
                walk_right = 1;
            end
        FALL:
            begin
                if(ground == 1) // If ground reappears
                    begin
                        if(state == WALK_LEFT) // Resume walking left
                            next_state = WALK_LEFT;
                        else // Resume walking right
                            next_state = WALK_RIGHT;
                    end
                else
                    next_state = FALL;
                    
                aaah = 1;
                walk_left = 0;
                walk_right = 0;
            end
        default:
            next_state = WALK_LEFT;
    endcase
end

endmodule
