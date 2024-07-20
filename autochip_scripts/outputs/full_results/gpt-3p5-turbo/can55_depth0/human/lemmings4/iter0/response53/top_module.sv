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

reg [4:0] state_reg;
reg [4:0] state_next;
reg walk_left_reg;
reg walk_right_reg;
reg aaah_reg;
reg digging_reg;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state_reg <= 5'b00000;
        walk_left_reg <= 1'b1;
        walk_right_reg <= 1'b0;
        aaah_reg <= 1'b0;
        digging_reg <= 1'b0;
    end else begin
        state_reg <= state_next;
        walk_left_reg <= walk_left_reg;
        walk_right_reg <= walk_right_reg;
        aaah_reg <= aaah_reg;
        digging_reg <= digging_reg;
    end
end

always @* begin
    state_next = state_reg;
    walk_left = walk_left_reg;
    walk_right = walk_right_reg;
    aaah = aaah_reg;
    digging = digging_reg;

    case (state_reg)
        0: begin  // walking to the left
            if (bump_left && !bump_right) begin
                state_next = 5'b01000;
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b0;
                digging = 1'b0;
            end else if (!ground) begin
                state_next = 5'b10000;
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b1;
                digging = 1'b0;
            end else if (dig) begin
                state_next = 5'b00100;
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b1;
            end
        end
        1: begin  // walking to the right
            if (!bump_left && bump_right) begin
                state_next = 5'b00100;
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end else if (!ground) begin
                state_next = 5'b10000;
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b1;
                digging = 1'b0;
            end else if (dig) begin
                state_next = 5'b01000;
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b0;
                digging = 1'b1;
            end
        end
        2: begin  // switched to walking to the right
            if (!ground) begin
                state_next = 5'b10000;
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b1;
                digging = 1'b0;
            end else if (dig) begin
                state_next = 5'b01000;
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b0;
                digging = 1'b1;
            end
        end
        3: begin  // switched to walking to the left
            if (!ground) begin
                state_next = 5'b10000;
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b1;
                digging = 1'b0;
            end else if (dig) begin
                state_next = 5'b00100;
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b1;
            end
        end
        4: begin  // falling
            if (ground) begin
                state_next = 5'b00000;
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b0;
                digging = 1'b0;
            end
        end
        5: begin  // digging
            if (!ground) begin
                state_next = 5'b10000;
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b1;
                digging = 1'b0;
            end
        end
        default: begin
            state_next = 5'b00000;
            walk_left = 1'b1;
            walk_right = 1'b0;
            aaah = 1'b0;
            digging = 1'b0;
        end
    endcase
end

endmodule
