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
        state <= 2'b10; // walking left state
    end
    else begin
        state <= next_state;
    end
end

always @(state or bump_left or bump_right) begin
    case (state)
        2'b00: begin // walking left state
            if (bump_left && bump_right) begin
                next_state = 2'b01; // switch direction state
            end
            else if (bump_left) begin
                next_state = 2'b01; // switch direction state
            end
            else if (bump_right) begin
                next_state = 2'b10; // continue walking left state
            end
            else begin
                next_state = 2'b00; // continue walking left state
            end
        end
        2'b01: begin // switch direction state
            next_state = 2'b10; // walking right state
        end
        2'b10: begin // walking right state
            if (bump_left && bump_right) begin
                next_state = 2'b01; // switch direction state
            end
            else if (bump_left) begin
                next_state = 2'b00; // continue walking right state
            end
            else if (bump_right) begin
                next_state = 2'b01; // switch direction state
            end
            else begin
                next_state = 2'b10; // continue walking right state
            end
        end
        default: next_state = state;
    endcase
end

always @(state) begin
    case (state)
        2'b00: begin // walking left state
            internal = 1; // walk left
        end
        2'b10: begin // walking right state
            internal = 0; // walk right
        end
        default: internal = 1; // default to walk left
    endcase
end

always @(posedge clk) begin
    walk_left <= internal;
    walk_right <= ~internal;
end

endmodule
