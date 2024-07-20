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

    // Define the states
    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL = 2'b10;
    parameter RESUME_LEFT = 2'b11;
    
    // Define the signals
    reg [1:0] state;
    reg [1:0] next_state;
    
    // Define the outputs
    reg walk_left;
    reg walk_right;
    reg aaah;
    
    // Define the asynchronous reset
    always @(posedge areset) begin
        state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
    end
    
    // Define the next state and output logic
    always @(posedge clk) begin
        if (areset) begin
            state <= WALK_LEFT;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
        end else begin
            state <= next_state;
            walk_left <= (state == WALK_LEFT);
            walk_right <= (state == WALK_RIGHT);
            aaah <= (state == FALL);
        end
    end
    
    // Define the state transition logic
    always @* begin
        case (state)
            WALK_LEFT:
                if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (ground == 0) begin
                    next_state = FALL;
                end else begin
                    next_state = WALK_LEFT;
                end
            WALK_RIGHT:
                if (bump_left) begin
                    next_state = WALK_LEFT;
                end else if (ground == 0) begin
                    next_state = FALL;
                end else begin
                    next_state = WALK_RIGHT;
                end
            FALL:
                if (ground == 1) begin
                    next_state = RESUME_LEFT;
                end else if (bump_left || bump_right) begin
                    next_state = FALL;
                end else begin
                    next_state = WALK_LEFT;
                end
            RESUME_LEFT:
                if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (bump_left || ground == 0) begin
                    next_state = RESUME_LEFT;
                end else begin
                    next_state = WALK_LEFT;
                end
        endcase
    end
    
endmodule
