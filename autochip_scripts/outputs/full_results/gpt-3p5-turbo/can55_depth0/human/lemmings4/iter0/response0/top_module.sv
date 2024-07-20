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

// Define states for the Moore state machine
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALLING = 2'b10;
parameter DIGGING = 2'b11;

// Define the state register and next state logic
reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

// Define the outputs for the Moore state machine
assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);
assign aaah = (state == FALLING || state == DIGGING);
assign digging = (state == DIGGING);

// Define the next state logic and output logic
always @* begin
    next_state = state;
    
    case(state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end else if (ground == 0) begin
                next_state = FALLING;
            end else if (dig) begin
                next_state = DIGGING;
            end
        end
        
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end else if (ground == 0) begin
                next_state = FALLING;
            end else if (dig) begin
                next_state = DIGGING;
            end
        end
        
        FALLING: begin
            if (ground) begin
                next_state = state;
            end else if (dig) begin
                next_state = DIGGING;
            end
        end
        
        DIGGING: begin
            if (ground == 0) begin
                next_state = FALLING;
            end
        end
    endcase
end

endmodule
