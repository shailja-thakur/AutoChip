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

reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00;  // walking left
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end else begin
        case (state)
            2'b00: begin  // walking left state
                if (bump_left == 1 && bump_right == 0) begin
                    state <= 2'b01;  // walking right state
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                end else if (bump_left == 0 && bump_right == 1) begin
                    state <= 2'b10;  // falling state
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end else if (ground == 0 && dig == 0) begin
                    state <= 2'b10;  // falling state
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end else if (ground == 1 && dig == 1) begin
                    state <= 2'b11;  // digging state
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end else begin
                    state <= 2'b00;  // walking left state
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
            end
            2'b01: begin  // walking right state
                if (bump_left == 1 && bump_right == 0) begin
                    state <= 2'b00;  // walking left state
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end else if (bump_left == 0 && bump_right == 1) begin
                    state <= 2'b10;  // falling state
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end else if (ground == 0 && dig == 0) begin
                    state <= 2'b10;  // falling state
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end else if (ground == 1 && dig == 1) begin
                    state <= 2'b11;  // digging state
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end else begin
                    state <= 2'b01;  // walking right state
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                end
            end
            2'b10: begin  // falling state
                if (bump_left == 0 && bump_right == 1) begin
                    state <= 2'b10;  // falling state
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end else if (ground == 1) begin
                    state <= 2'b00;  // walking left state
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end else if (dig == 1) begin
                    state <= 2'b11;  // digging state
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end else begin
                    state <= 2'b10;  // falling state
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end
            end
            2'b11: begin  // digging state
                if (ground == 0) begin
                    state <= 2'b10;  // falling state
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end else if (dig == 0) begin
                    state <= 2'b00;  // walking left state
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end else begin
                    state <= 2'b11;  // digging state
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
            end
            default:begin  // should not reach this state
                state <= 2'b00;  // reset to walking left state
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
        endcase
    end
end

endmodule
