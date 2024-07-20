module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    reg [1:0] next_state_reg, current_state_reg;

    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state_reg <= 2'b00;
        else
            current_state_reg <= next_state_reg;
    end

    always @(current_state_reg or bump_left or bump_right) begin
        case (current_state_reg)
            2'b00: begin // Walking left
                if (bump_left)
                    next_state_reg = 2'b01; // Switch to walking right
                else if (bump_right)
                    next_state_reg = 2'b10; // Stay left but switch direction
                else
                    next_state_reg = 2'b00; // Continue walking left
            end
            2'b01: begin // Walking right
                if (bump_right)
                    next_state_reg = 2'b00; // Switch to walking left
                else if (bump_left)
                    next_state_reg = 2'b10; // Stay right but switch direction
                else
                    next_state_reg = 2'b01; // Continue walking right
            end
            default: begin
                next_state_reg = 2'b00; // Default to left if unknown state
            end
        endcase
    end

    always @(posedge clk) begin
        case (current_state_reg)
            2'b00: begin // Walking left
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            2'b01: begin // Walking right
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
            default: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule
