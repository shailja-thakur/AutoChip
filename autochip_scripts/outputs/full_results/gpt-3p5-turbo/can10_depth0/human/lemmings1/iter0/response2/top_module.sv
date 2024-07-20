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
            state <= 2'b01;   // start in walking left state
        end 
        else begin
            case (state)
                2'b00: begin   // walking left state
                    if (bump_left) begin
                        state <= 2'b10;   // switch to walking right state
                    end
                end
                2'b01: begin   // walking right state
                    if (bump_right) begin
                        state <= 2'b00;   // switch to walking left state
                    end
                end
                default: begin
                    state <= 2'b01;   // default to walking right state
                end
            endcase
        end
    end
    
    assign walk_left = (state == 2'b00);
    assign walk_right = (state == 2'b01);
    
endmodule
