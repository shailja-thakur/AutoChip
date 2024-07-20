module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg [1:0] state; // state represents the current state of the state machine
    reg walk_left;  // output signal for walking left
    reg walk_right; // output signal for walking right

    // The initial state
    initial begin
        state = 2'b01; // Initial state is walking left
        walk_left = 1'b1;
        walk_right = 1'b0;
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset the state to walking left
        end 
        else begin
            case(state)
                2'b00: begin // Walking right state
                    if (bump_left || bump_right) begin // If bumped on either side, switch directions
                        state <= 2'b01; // Go to walking left state
                    end 
                    else begin
                        state <= 2'b00; // Proceed walking right
                    end
                end
                2'b01: begin // Walking left state
                    if (bump_left || bump_right) begin // If bumped on either side, switch directions
                        state <= 2'b00; // Go to walking right state
                    end 
                    else begin
                        state <= 2'b01; // Proceed walking left
                    end
                end
            endcase
        end
    end

    always @(state) begin
        case(state)
            2'b00: begin // Walking right state
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
            2'b01: begin // Walking left state
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule
