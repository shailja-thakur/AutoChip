module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

reg [1:0] state;
reg internal;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b10; // walking left state
    end
    else begin
        case (state)
            2'b00: begin // walking left state
                if (bump_left && bump_right) begin
                    state <= 2'b01; // switch direction state
                end
                else if (bump_left) begin
                    state <= 2'b01; // switch direction state
                end
                else if (bump_right) begin
                    state <= 2'b00; // continue walking left state
                end
                else begin
                    state <= 2'b00; // continue walking left state
                end
            end
            2'b01: begin // switch direction state
                state <= 2'b10; // walking right state
            end
            2'b10: begin // walking right state
                if (bump_left && bump_right) begin
                    state <= 2'b01; // switch direction state
                end
                else if (bump_left) begin
                    state <= 2'b00; // continue walking right state
                end
                else if (bump_right) begin
                    state <= 2'b01; // switch direction state
                end
                else begin
                    state <= 2'b10; // continue walking right state
                end
            end
        endcase
    end
end

always @(state) begin
    case (state)
        2'b00: begin // walking left state
            internal = 1; // walk left
        end
        2'b10: begin // walking right state
            internal = 0; // walk right
        end
    endcase
end

assign walk_left = internal;
assign walk_right = ~internal;

endmodule
