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

    // Define state variables
    reg [1:0] state;

    // Define outputs
    assign walk_left = (state == 2'b00);
    assign walk_right = (state == 2'b01);
    assign aaah = (state == 2'b10);
    assign digging = (state == 2'b11);

    // Define state transitions and outputs
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // Initialize state to walking left
        end else begin
            case(state)
                2'b00: begin // Walking left state
                    if (bump_right) begin
                        state <= 2'b01; // Switch to walking right
                    end else if (!ground) begin
                        state <= 2'b10; // Fall state
                    end else if (dig) begin
                        state <= 2'b11; // Digging state
                    end
                end
                2'b01: begin // Walking right state
                    if (bump_left) begin
                        state <= 2'b00; // Switch to walking left
                    end else if (!ground) begin
                        state <= 2'b10; // Fall state
                    end else if (dig) begin
                        state <= 2'b11; // Digging state
                    end
                end
                2'b10: begin // Fall state
                    if (ground) begin
                        state <= (bump_left || bump_right) ? state : (walk_left ? 2'b00 : 2'b01); // Resume walking in the same direction
                    end
                end
                2'b11: begin // Digging state
                    if (!ground) begin
                        state <= 2'b10; // Fall state
                    end
                end
            endcase
        end
    end

endmodule
