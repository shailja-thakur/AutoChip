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
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 3'b001; // Start in "walking left" state
        end else begin
            case(state)
                3'b001: begin // walking left state
                    if (bump_right) begin
                        state <= 3'b010; // switch to "walking right" state on right bump
                    end else if (ground == 0 && !dig) begin
                        state <= 3'b011; // switch to "falling" state when ground disappears
                    end
                end
                3'b010: begin // walking right state
                    if (bump_left) begin
                        state <= 3'b001; // switch to "walking left" state on left bump
                    end else if (ground == 0 && !dig) begin
                        state <= 3'b011; // switch to "falling" state when ground disappears
                    end
                end
                3'b011: begin // falling state
                    if (ground == 1) begin
                        if (state == 3'b001) begin
                            state <= 3'b001; // return to "walking left" state after fall if originally walking left
                        end else if (state == 3'b010) begin
                            state <= 3'b010; // return to "walking right" state after fall if originally walking right
                        end
                    end
                end
            endcase
        end
    end
    
    always @(state) begin
        // Reset outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case(state)
            3'b001: begin // walking left state
                walk_left = 1;
            end
            3'b010: begin // walking right state
                walk_right = 1;
            end
            3'b011: begin // falling state
                aaah = 1;
            end
        endcase
        
        // Check if digging is allowed
        if (state == 3'b001 && ground == 1 && !dig) begin
            digging = 1;
        end
    end
    
endmodule
