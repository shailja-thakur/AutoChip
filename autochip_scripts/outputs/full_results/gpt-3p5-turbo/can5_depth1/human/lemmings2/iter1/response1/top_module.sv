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

// Define state encoding
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALLING = 2'b10;
parameter RESUME = 2'b11;

// Define state register and next state logic
reg [1:0] current_state;
reg [1:0] next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
    end
    else begin
        current_state <= next_state;
    end
end

// Define output logic
always @(current_state) begin
    case (current_state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
        end
        FALLING: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
        end
        RESUME: begin
            if (current_state == WALK_LEFT) begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
            else begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end
        end
        default: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
        end
    endcase
end

// Define next state logic
always @* begin
    case (current_state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (ground == 0) begin
                next_state = FALLING;
            end
            else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (ground == 0) begin
                next_state = FALLING;
            end
            else begin
                next_state = WALK_RIGHT;
            end
        end
        FALLING: begin
            if (ground) begin
                next_state = RESUME;
            end
            else begin
                next_state = FALLING;
            end
        end
        RESUME: begin
            if (current_state == WALK_LEFT) begin
                next_state = WALK_LEFT;
            end
            else begin
                next_state = WALK_RIGHT;
            end
        end
        default: next_state = WALK_LEFT;
    endcase
end

endmodule
