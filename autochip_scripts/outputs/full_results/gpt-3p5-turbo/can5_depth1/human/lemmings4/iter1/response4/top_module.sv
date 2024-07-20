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
    reg fall;
    reg [4:0] fall_count;
    
    always @(posedge clk) begin
        if (areset) begin
            state <= 0;
            fall <= 0;
            fall_count <= 0;
        end else begin
            case (state)
                0: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    if (ground) begin
                        if (bump_left) begin
                            state <= 1;
                        end else if (dig) begin
                            if(!fall) begin
                                state <= 2;
                            end
                        end
                    end else begin
                        aaah <= 1;
                        fall <= 1;
                        fall_count <= 0;
                        state <= 3;
                    end
                end
                1: begin
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                    if (ground) begin
                        if (bump_right) begin
                            walk_left <= 1;
                            walk_right <= 0;
                            state <= 0;
                        end else if (dig) begin
                            if(!fall) begin
                                state <= 2;
                            end
                        end
                    end else begin
                        aaah <= 1;
                        fall <= 1;
                        fall_count <= 0;
                        state <= 3;
                    end
                end
                2: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    if (ground) begin
                        if (bump_left) begin
                            state <= 1;
                        end else if (dig) begin
                            if(!fall) begin
                                state <= 2;
                            end
                        end
                    end else if (dig && !ground) begin
                        digging <= 1;
                        state <= 2;
                    end else begin
                        aaah <= 1;
                        fall <= 1;
                        fall_count <= 0;
                        state <= 3;
                    end
                end
                3: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                    if (ground) begin
                        fall <= 0;
                        state <= 0;
                    end else begin
                        fall_count <= fall_count + 1;
                        if (fall_count > 20) begin
                            // Lemming has fallen for too long, splatter
                            walk_left <= 0;
                            walk_right <= 0;
                            aaah <= 0;
                            digging <= 0;
                            state <= 4;
                        end else begin
                            state <= 3;
                        end
                    end
                end
                4: begin
                    // Lemming has splattered
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    state <= 4;
                end
                default: state <= 0;
            endcase
        end
    end
    
endmodule
