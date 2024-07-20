module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

reg [1:0] state;

// State machine parameters
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        case (state)
            WALK_LEFT: begin
                if (bump_right) begin
                    state <= WALK_RIGHT;
                end else if (bump_left || (bump_left && bump_right)) begin
                    state <= WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    state <= WALK_LEFT;
                end else if (bump_right || (bump_left && bump_right)) begin
                    state <= WALK_RIGHT;
                end
            end
            default: state <= WALK_LEFT;
        endcase
    end
end

// Assign outputs based on state
always @(state) begin
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
        end
        default: begin
            walk_left = 1;
            walk_right = 0;
        end
    endcase
end

endmodule
