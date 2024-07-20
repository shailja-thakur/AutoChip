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

    reg walk_left;
    reg walk_right;
    reg aaah;
    reg digging;
    reg [1:0] state;

    always @(posedge clk or posedge areset)
        if (areset)
            state <= 2'b01;
        else
            case (state)
                2'b00: begin // Walking left state
                    walk_left = 1;
                    walk_right = 0;
                    aaah = 0;
                    digging = 0;
                    if (bump_left)
                        state <= 2'b10;
                    else if (bump_right)
                        state <= 2'b11;
                    else if (~ground)
                        state <= 2'b00;
                end
                2'b01: begin // Walking right state
                    walk_left = 0;
                    walk_right = 1;
                    aaah = 0;
                    digging = 0;
                    if (bump_right)
                        state <= 2'b00;
                    else if (bump_left)
                        state <= 2'b11;
                    else if (~ground)
                        state <= 2'b00;
                end
                2'b10: begin // Bumped left state
                    walk_left = 0;
                    walk_right = 1;
                    aaah = 0;
                    digging = 0;
                    if (bump_right)
                        state <= 2'b00;
                    else if (~ground)
                        state <= 2'b00;
                end
                2'b11: begin // Bumped right state
                    walk_left = 1;
                    walk_right = 0;
                    aaah = 0;
                    digging = 0;
                    if (bump_left)
                        state <= 2'b10;
                    else if (~ground)
                        state <= 2'b00;
                end
            endcase
    
    always @(state, ground, dig)
        case (state)
            2'b00: begin // Falling state
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
                if (ground)
                    if (dig)
                        state <= 2'b00;
                    else
                        state <= 2'b01;
            end
            2'b01: begin // Walking on ground state
                walk_left = walk_left;
                walk_right = walk_right;
                aaah = 0;
                digging = 0;
                if (~ground)
                    if (dig)
                        state <= 2'b00;
                    else
                        state <= 2'b00;
            end
        endcase

endmodule
