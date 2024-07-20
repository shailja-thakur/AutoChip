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
    reg [4:0] count;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 5'b00001;  // reset state to walk_left
            count <= 5'b00000;  // reset count to 0
        end else begin
            case(state)

                // Walking Left state
                5'b00001: begin
                    walk_left <= 1;
                    walk_right <= 0;    
                    count <= 5'b00000;
                    if (bump_right) begin
                        state <= 5'b00010;  // bumped on right, change to walking right state
                    end else if (bump_left) begin
                        state <= 5'b00010;  // bumped on left, change to walking right state
                    end else if (ground == 0) begin
                        state <= 5'b00100;  // ground disappeared, change to falling state
                    end else if (dig) begin
                        state <= 5'b00110;  // dig command received, change to digging state
                    end
                end

                // Walking Right state
                5'b00010: begin
                    walk_left <= 0;
                    walk_right <= 1;
                    count <= 5'b00000;
                    if (bump_left) begin
                        state <= 5'b00001;  // bumped on left, change to walking left state
                    end else if (bump_right) begin
                        state <= 5'b00001;  // bumped on right, change to walking left state
                    end else if (ground == 0) begin
                        state <= 5'b00100;  // ground disappeared, change to falling state
                    end else if (dig) begin
                        state <= 5'b00110;  // dig command received, change to digging state
                    end
                end

                // Falling state
                5'b00100: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    count <= count + 1;
                    if (ground) begin
                        state <= 5'b00101;  // ground reappeared, change to walking state
                    end else if (count >= 5'b10100) begin
                        state <= 5'b00111;  // fall for too long, change to splatter state
                    end
                end

                // Ground Reappeared state
                5'b00101: begin
                    walk_left <= walk_left;
                    walk_right <= walk_right;
                    count <= 5'b00000;
                    state <= walk_left ? 5'b00001 : 5'b00010;  // resume walking in the same direction as before fall
                end

                // Digging state
                5'b00110: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    count <= count + 1;
                    if (~ground) begin
                        state <= 5'b00100;  // ground disappeared, change to falling state
                    end else if (count >= 5'b10100) begin
                        state <= 5'b00111;  // fall for too long, change to splatter state
                    end
                end

                // Splatter state
                5'b00111: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    count <= 5'b00000;
                    state <= 5'b00111;  // remain in splatter state forever
                end

                default: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    count <= 5'b00000;
                    state <= 5'b00001;  // default state to walk_left
                end
            endcase
        end
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            aaah <= 0;
            digging <= 0;
        end else begin
            case(state)
                5'b00100, 5'b00110:
                    aaah <= 1;
                default:
                    aaah <= 0;
                endcase

            case(state)
                5'b00110:
                    digging <= 1;
                default:
                    digging <= 0;
                endcase
        end
    end
endmodule
