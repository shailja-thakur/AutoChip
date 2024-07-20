module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

reg [1:0] state;
reg internal;
reg [1:0] next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b10; // walking right state
        walk_left <= 0;
        walk_right <= 1;
    end
    else begin
        state <= next_state;
        walk_left <= internal;
        walk_right <= ~internal;
    end
end

always @(state or bump_left or bump_right) begin
    case (state)
        2'b00: begin // walking left state
            if (bump_left && !bump_right) begin
                next_state = 2'b01; // switch direction state
                internal = 0; // walk right
            end
            else if (!bump_left && bump_right) begin
                next_state = 2'b01; // switch direction state
                internal = 1; // walk left
            end
            else begin
                next_state = 2'b00; // continue walking left state
                internal = 1; // walk left
            end
        end
        2'b01: begin // switch direction state
            next_state = 2'b10; // walking right state
            internal = 0; // walk right
        end
        2'b10: begin // walking right state
            if (bump_left && !bump_right) begin
                next_state = 2'b01; // switch direction state
                internal = 1; // walk left
            end
            else if (!bump_left && bump_right) begin
                next_state = 2'b01; // switch direction state
                internal = 0; // walk right
            end
            else begin
                next_state = 2'b10; // continue walking right state
                internal = 0; // walk right
            end
        end
        default: next_state = state;
    endcase
end

endmodule
