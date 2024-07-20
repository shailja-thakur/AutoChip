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
    
    // Define the states
    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL,
        DIG
    } state_t;
    
    // Define the state register and next state variables
    logic [2:0] state_reg;
    logic [2:0] state_next;
    
    // Define the outputs of the module
    assign walk_left = (state_reg == WALK_LEFT);
    assign walk_right = (state_reg == WALK_RIGHT);
    assign aaah = (state_reg == FALL);
    assign digging = (state_reg == DIG);
    
    // Define the state transition and output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state_reg <= WALK_LEFT;
        end else begin
            state_reg <= state_next;
        end
    end
    
    always_comb begin
        state_next = state_reg;
        
        case(state_reg)
            WALK_LEFT: begin
                if (bump_right && !bump_left && ground) begin
                    state_next = WALK_RIGHT;
                end else if (!ground) begin
                    state_next = FALL;
                end else if (dig && ground) begin
                    state_next = DIG;
                end
            end
            
            WALK_RIGHT: begin
                if (bump_left && !bump_right && ground) begin
                    state_next = WALK_LEFT;
                end else if (!ground) begin
                    state_next = FALL;
                end else if (dig && ground) begin
                    state_next = DIG;
                end
            end
            
            FALL: begin
                if (ground) begin
                    state_next = state_reg;
                end
            end
            
            DIG: begin
                if (!ground) begin
                    state_next = FALL;
                end
            end
        endcase
    end

endmodule
