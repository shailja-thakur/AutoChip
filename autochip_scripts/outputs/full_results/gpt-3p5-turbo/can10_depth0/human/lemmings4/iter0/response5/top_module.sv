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

    reg [4:0] state;
    reg falling;
    reg [4:0] fall_count;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 5'b00000; // initial state: walking left
            falling <= 1'b0;
            fall_count <= 5'b00000;
        end else begin
            case (state)
                5'b00000: // walking left
                    if (bump_right) begin
                        state <= 5'b00001; // start walking right
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                    end else if (ground == 1'b0) begin
                        state <= 5'b00100; // falling
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                    end else if (dig == 1'b1 && ground == 1'b1) begin
                        state <= 5'b00010; // start digging
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                    end
                5'b00001: // walking right
                    if (bump_left) begin
                        state <= 5'b00000; // start walking left
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                    end else if (ground == 1'b0) begin
                        state <= 5'b00100; // falling
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                    end else if (dig == 1'b1 && ground == 1'b1) begin
                        state <= 5'b00010; // start digging
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                    end
                5'b00010: // start digging
                    if (ground == 1'b0) begin
                        state <= 5'b00010; // continue digging
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                    end else begin
                        state <= 5'b00011; // stop digging
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                    end
                5'b00011: // stop digging
                    if (ground == 1'b0) begin
                        state <= 5'b00100; // falling
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                    end else begin
                        if (walk_right) begin
                            state <= 5'b00001; // start walking right
                            walk_left <= 1'b0;
                            walk_right <= 1'b1;
                        end else begin
                            state <= 5'b00000; // start walking left
                            walk_left <= 1'b1;
                            walk_right <= 1'b0;
                        end
                    end
                5'b00100: // falling
                    if (ground == 1'b1 && falling) begin
                        state <= 5'b00101; // splatter
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                    end else begin
                        state <= 5'b00100; // continue falling
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                    end
                5'b00101: // splatter
                    state <= 5'b00101;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                default: // should not happen
                    state <= 5'b00000;
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
            endcase
        end
    end

    always @(posedge clk) begin
        if (areset) begin
            aaah <= 1'b0;
            digging <= 1'b0;
        end else begin
            case (state)
                5'b00000: // walking left
                5'b00001: // walking right
                5'b00011: // stop digging
                    aaah <= 1'b0;
                    digging <= 1'b0;
                5'b00010: // start digging
                    aaah <= 1'b0;
                    digging <= 1'b1;
                5'b00100: // falling
                    aaah <= 1'b1;
                    digging <= 1'b0;
                5'b00101: // splatter
                    aaah <= 1'b0;
                    digging <= 1'b0;
                default: // should not happen
                    aaah <= 1'b0;
                    digging <= 1'b0;
            endcase
        end
    end

    always @(posedge clk) begin
        if (areset) begin
            falling <= 1'b0;
        end else if (state == 5'b00100 && ground == 1'b0) begin
            falling <= 1'b1;
            fall_count <= fall_count + 1;
        end else if (state == 5'b00100 && ground == 1'b1) begin
            falling <= 1'b0;
            fall_count <= 5'b00000;
        end 
    end

    always @(posedge clk) begin
        if (areset) begin
            aaah <= 1'b0;
            digging <= 1'b0;
        end else if (fall_count >= 5'd20) begin
            aaah <= 1'b0;
            digging <= 1'b0;
        end 
    end

endmodule
