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
            state <= 2'b10; // Set initial state to walking left
        end else begin
            case(state)
                2'b00: begin // State when Lemming is walking left
                    if (bump_left && !bump_right) begin
                        state <= 2'b01; // Transition to walking right state
                    end
                end
                2'b01: begin // State when Lemming is walking right
                    if (!bump_left && bump_right) begin
                        state <= 2'b00; // Transition to walking left state
                    end
                end
                2'b10: begin // State when Lemming is bumped on both sides
                    if (!bump_left && !bump_right) begin
                        state <= 2'b00; // Transition to walking left state
                    end
                end
            endcase
        end
    end
    
    assign walk_left = (state == 2'b00);
    assign walk_right = (state == 2'b01);
    
endmodule
