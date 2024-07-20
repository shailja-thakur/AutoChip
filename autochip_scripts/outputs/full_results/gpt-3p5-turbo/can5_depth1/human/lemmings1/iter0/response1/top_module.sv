module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg walk_left, walk_right;
    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;  // Initialize state to "walk_left"
        end else begin
            case(state)
                2'b00: begin  // Walking left state
                    if (bump_right) begin
                        state <= 2'b01;  // Switch to "walk_right" state
                    end else if (bump_left) begin
                        state <= 2'b00;  // Stay in "walk_left" state
                    end
                    // Else, stay in "walk_left" state
                end
                2'b01: begin  // Walking right state
                    if (bump_left) begin
                        state <= 2'b00;  // Switch to "walk_left" state
                    end else if (bump_right) begin
                        state <= 2'b01;  // Stay in "walk_right" state
                    end
                    // Else, stay in "walk_right" state
                end
                default: state <= 2'b00;  // Default to "walk_left" state
            endcase
        end
    end
    
    // Assign output signals based on the current state
    assign walk_left = (state == 2'b00);
    assign walk_right = (state == 2'b01);

endmodule
