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
localparam [1:0] WALK_LEFT = 2'b00;
localparam [1:0] WALK_RIGHT = 2'b01;
localparam [1:0] FALL = 2'b10;
localparam [1:0] DIG = 2'b11;

// Define state register
reg [1:0] state;

// Next state logic
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= WALK_LEFT;
    else begin
        case (state)
            WALK_LEFT: begin
                if (bump_right || (bump_left && bump_right))
                    state <= WALK_RIGHT;
                else if (!ground)
                    state <= FALL;
                else if (dig)
                    state <= DIG;
            end
            WALK_RIGHT: begin
                if (bump_left || (bump_left && bump_right))
                    state <= WALK_LEFT;
                else if (!ground)
                    state <= FALL;
                else if (dig)
                    state <= DIG;
            end
            FALL: begin
                if (ground)
                    state <= state[1] ? WALK_RIGHT : WALK_LEFT;
            end
            DIG: begin
                if (!ground)
                    state <= FALL;
            end
        endcase
    end
end

// Output logic
always @(state, ground) begin
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
        end
        FALL: begin
            walk_left = state[1] ? 1 : 0;
            walk_right = state[1] ? 0 : 1;
            aaah = 1;
            digging = 0;
        end
        DIG: begin
            walk_left = state[1] ? 1 : 0;
            walk_right = state[1] ? 0 : 1;
            aaah = 0;
            digging = 1;
        end
    endcase
end

endmodule
