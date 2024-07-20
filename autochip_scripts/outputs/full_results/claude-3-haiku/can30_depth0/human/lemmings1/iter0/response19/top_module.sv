module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Define the states
localparam [0:0] WALK_LEFT = 1'b0;
localparam [0:0] WALK_RIGHT = 1'b1;

// State variable
reg [0:0] current_state, next_state;

// State transition logic
always @(*) begin
    case (current_state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end else begin
                next_state = WALK_RIGHT;
            end
        end
        default: begin
            next_state = WALK_LEFT;
        end
    endcase
end

// Output logic
always @(*) begin
    case (current_state)
        WALK_LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
        end
        WALK_RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
        end
        default: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
        end
    endcase
end

// State register
always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
    end else begin
        current_state <= next_state;
    end
end

endmodule
