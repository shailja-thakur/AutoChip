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

reg [4:0] state;
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 5'b00000;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end else begin
        case(state)
            0: begin // walking left
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                if (bump_left) begin
                    state <= 1;
                end else if (bump_right) begin
                    state <= 2;
                end else if (dig) begin
                    state <= 3;
                end else if (!ground) begin
                    state <= 4;
                end
            end
            1: begin // walking right - bumped on left
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                if (bump_right) begin
                    state <= 2;
                end else if (dig) begin
                    state <= 3;
                end else if (!ground) begin
                    state <= 4;
                end else if (ground && !dig) begin
                    state <= 0;
                end
            end
            2: begin // walking left - bumped on right
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                if (bump_left) begin
                    state <= 1;
                end else if (dig) begin
                    state <= 3;
                end else if (!ground) begin
                    state <= 4;
                end else if (ground && !dig) begin
                    state <= 0;
                end
            end
            3: begin // digging
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
                if (!ground) begin
                    state <= 4;
                end
            end
            4: begin // falling - aaah!
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                if (ground && !dig) begin
                    state <= 0;
                end
            end
            5: begin // splattered
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                if (areset) begin
                    state <= 0;
                end
            end
        endcase
    end
end

endmodule
