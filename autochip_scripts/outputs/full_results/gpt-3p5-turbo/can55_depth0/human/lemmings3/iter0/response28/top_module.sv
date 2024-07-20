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

// Define states
typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALLING,
    DIGGING
} state_t;

// Define inputs
localparam logic BUMP_LEFT = 1;
localparam logic BUMP_RIGHT = 1;
localparam logic NO_BUMP = 0;
localparam logic DIG_ENABLE = 1;
localparam logic DIG_DISABLE = 0;

// Declare registers for state and output
reg [1:0] current_state;
reg fall_trigger;
reg [1:0] next_state;

// Assign initial values
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= DIG_DISABLE;
    end
end

// Transition and output logic
always @(posedge clk) begin
    if (areset) begin
        next_state <= WALK_LEFT;
    end else begin
        case (current_state)
            WALK_LEFT:
                if (bump_right) begin
                    next_state <= WALK_RIGHT;
                end else if (bump_left) begin
                    next_state <= WALK_LEFT;
                end else if (!ground) begin
                    next_state <= FALLING;
                end else if (dig && ground) begin
                    next_state <= DIGGING;
                end else begin
                    next_state <= WALK_LEFT;
                end
            
            WALK_RIGHT:
                if (bump_left) begin
                    next_state <= WALK_LEFT;
                end else if (bump_right) begin
                    next_state <= WALK_RIGHT;
                end else if (!ground) begin
                    next_state <= FALLING;
                end else if (dig && ground) begin
                    next_state <= DIGGING;
                end else begin
                    next_state <= WALK_RIGHT;
                end
            
            FALLING:
                if (ground) begin
                    next_state <= current_state;
                end else begin
                    next_state <= FALLING;
                end
            
            DIGGING:
                if (!ground) begin
                    next_state <= FALLING;
                end else if (dig) begin
                    next_state <= DIGGING;
                end else begin
                    next_state <= WALK_LEFT;
                end
        endcase
    end
end

// Update state and outputs
always @(posedge clk) begin
    if (areset) begin
        fall_trigger <= 0;
    end else begin
        case (current_state)
            FALLING:
                fall_trigger <= 1;
                
            default:
                fall_trigger <= 0;
        endcase
        
        current_state <= next_state;
        
        case (current_state)
            WALK_LEFT:
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= DIG_DISABLE;
                
            WALK_RIGHT:
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= DIG_DISABLE;
                
            FALLING:
                walk_left <= 0;
                walk_right <= 0;
                aaah <= fall_trigger;
                digging <= DIG_DISABLE;
                
            DIGGING:
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= DIG_ENABLE;
        endcase
    end
end

endmodule
