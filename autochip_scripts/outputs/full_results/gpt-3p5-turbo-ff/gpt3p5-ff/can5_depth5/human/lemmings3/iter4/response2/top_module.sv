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

    reg [2:0] state;

    parameter WALK_LEFT = 3'b001;
    parameter WALK_RIGHT = 3'b010;
    parameter FALL = 3'b011;
    parameter DIG = 3'b100;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
        end else begin
            case(state)
                WALK_LEFT: begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                    if(bump_right) begin
                        state <= WALK_RIGHT;
                    end else if (!ground) begin
                        state <= FALL;
                    end else if (dig) begin
                        state <= DIG;
                    end
                end
                WALK_RIGHT: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                    if(bump_left) begin
                        state <= WALK_LEFT;
                    end else if (!ground) begin
                        state <= FALL;
                    end else if (dig) begin
                        state <= DIG;
                    end
                end
                FALL: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b1;
                    digging <= 1'b0;
                    if(ground) begin
                        if(bump_right) begin
                            state <= WALK_LEFT;
                        end else if (bump_left) begin
                            state <= WALK_RIGHT;
                        end else begin
                            if(state == WALK_LEFT) begin
                                state <= WALK_LEFT;
                            end else if(state == WALK_RIGHT) begin
                                state <= WALK_RIGHT;
                            end 
                        end
                    end else begin
                        if(bump_right) begin
                            state <= WALK_LEFT;
                        end else if (bump_left) begin
                            state <= WALK_RIGHT;
                        end else if (dig) begin
                            state <= DIG;
                        end
                    end
                end
                DIG: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b1;
                    if(!ground) begin
                        state <= FALL;
                    end
                end
            endcase
        end
    end

endmodule
