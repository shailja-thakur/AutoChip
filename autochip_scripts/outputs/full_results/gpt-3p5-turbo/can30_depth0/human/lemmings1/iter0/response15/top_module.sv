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
            state <= 2'b01; // Initialize state to walk left
        end
        else begin
            case (state)
                2'b01: begin // Walking left state
                    if (bump_right) begin
                        state <= 2'b10; // Switch to walk right state if bumped on right
                    end
                    else if (bump_left) begin
                        state <= 2'b00; // Switch to walk left state if bumped on left
                    end
                end
                
                2'b10: begin // Walking right state
                    if (bump_left) begin
                        state <= 2'b00; // Switch to walk left state if bumped on left
                    end
                    else if (bump_right) begin
                        state <= 2'b01; // Switch to walk right state if bumped on right
                    end
                end
            endcase
        end
    end
    
    assign walk_left = (state == 2'b01); // Output walk_left if in walking left state
    assign walk_right = (state == 2'b10); // Output walk_right if in walking right state

endmodule
