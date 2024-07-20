module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

    // Declare the state register
    reg [1:0] state;

    // Declare the outputs
    assign walk_left = (state == 2'b00);
    assign walk_right = (state == 2'b01);
    assign aaah = (state == 2'b10);

    // Define the state transitions and outputs
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // Initialize the state to walk_left
        end else begin
            case (state)
                2'b00: begin // Current state is walk_left
                    if (bump_right) begin
                        state <= 2'b01; // Switch to walk_right state
                    end else if (bump_left) begin
                        state <= 2'b00; // Stay in the walk_left state
                    end else if (!ground) begin
                        state <= 2'b10; // Transition to aaah state
                    end
                end
                2'b01: begin // Current state is walk_right
                    if (bump_left) begin
                        state <= 2'b00; // Switch to walk_left state
                    end else if (bump_right) begin
                        state <= 2'b01; // Stay in the walk_right state
                    end else if (!ground) begin
                        state <= 2'b10; // Transition to aaah state
                    end
                end
                2'b10: begin // Current state is aaah
                    if (ground) begin
                        state <= 2'b00; // Transition to walk_left state
                    end
                end
            endcase
        end
    end

endmodule
