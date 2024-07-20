module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;  // reset state to walk_left
        end else begin
            case (state)
                2'b01: begin  // walking left state
                    if (bump_right) begin
                        state <= 2'b10;  // switch to walking right state
                    end else begin
                        state <= 2'b01;  // continue walking left
                    end
                end
                
                2'b10: begin  // walking right state
                    if (bump_left) begin
                        state <= 2'b01;  // switch to walking left state
                    end else begin
                        state <= 2'b10;  // continue walking right
                    end
                end
            endcase
        end
    end
    
    assign walk_left = (state == 2'b01);
    assign walk_right = (state == 2'b10);
    
endmodule
