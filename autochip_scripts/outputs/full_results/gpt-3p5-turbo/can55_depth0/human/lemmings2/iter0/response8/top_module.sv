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

// Define internal signals
reg [1:0] state;
reg [1:0] next_state;

// Initialize state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

// Define outputs
assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);
assign aaah = (state == FALL);

// Update next state based on inputs
always @(state, bump_left, bump_right, ground) begin
    case(state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end else if (ground == 0) begin
                next_state = FALL;
            end else begin
                next_state = WALK_LEFT;
            end
        end
        
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end else if (ground == 0) begin
                next_state = FALL;
            end else begin
                next_state = WALK_RIGHT;
            end
        end
        
        FALL: begin
            if (ground) begin
                if (state == WALK_LEFT) begin
                    next_state = WALK_LEFT;
                end else if (state == WALK_RIGHT) begin
                    next_state = WALK_RIGHT;
                end
            end else begin
                next_state = FALL;
            end
        end
    endcase
end

endmodule
