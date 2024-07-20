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

    // State declaration
    reg [1:0] state;
    
    // Output declaration
    reg walk_left;
    reg walk_right;
    reg aaah;
    reg digging;

    // Define the states
    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL = 2'b10;
    parameter DIG = 2'b11;
    
    // Initial state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            case (state)
                WALK_LEFT: begin
                    if (bump_right) begin
                        state <= WALK_RIGHT;
                    end else if (!ground) begin
                        state <= FALL;
                    end else if (dig) begin
                        state <= DIG;
                    end
                end
                
                WALK_RIGHT: begin
                    if (bump_left) begin
                        state <= WALK_LEFT;
                    end else if (!ground) begin
                        state <= FALL;
                    end else if (dig) begin
                        state <= DIG;
                    end
                end
                
                FALL: begin
                    if (ground) begin
                        if (state == WALK_LEFT) begin
                            walk_left <= 1;
                            walk_right <= 0;
                        end else if (state == WALK_RIGHT) begin
                            walk_left <= 0;
                            walk_right <= 1;
                        end
                        
                        aaah <= 0;
                        
                        if (dig) begin
                            state <= DIG;
                        end else begin
                            state <= state;
                        end
                    end else begin
                        aaah <= 1;
                        state <= state;
                    end
                end
                
                DIG: begin
                    if (!ground) begin
                        state <= FALL;
                    end else begin
                        if (state == WALK_LEFT) begin
                            walk_left <= 1;
                            walk_right <= 0;
                        end else if (state == WALK_RIGHT) begin
                            walk_left <= 0;
                            walk_right <= 1;
                        end
                        
                        digging <= 1;
                        
                        state <= state;
                    end
                end
            endcase
        end
    end

    // Output assignments
    always @(state) begin
        case (state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
            
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
            end
            
            FALL: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
            end
            
            DIG: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
            end
        endcase
    end

endmodule
