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

    /* State definition */
    reg [1:0] state;

    /* Outputs */
    assign walk_left = (state == 2);
    assign walk_right = (state == 1);
    assign aaah = (state == 3);
    assign digging = (state == 4);

    /* State machine */
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2; // Start in the walking left state
        end else case (state)
            1: begin // walking right
                if (bump_left || (bump_left && bump_right)) begin
                    state <= 2; // switch direction
                end else if (ground) begin
                    state <= 1; // continue walking right
                end else begin
                    state <= 3; // fall
                end
            end
            2: begin // walking left
                if (bump_right || (bump_left && bump_right)) begin
                    state <= 1; // switch direction
                end else if (ground) begin
                    state <= 2; // continue walking left
                end else begin
                    state <= 3; // fall
                end
            end
            3: begin // falling
                if (ground) begin
                    state <= state; // maintain falling state until landing
                end else begin
                    state <= 3; // continue falling
                end
            end 
            4: begin // digging
                if (ground && !dig) begin
                    state <= 2; // continue walking after digging
                end else begin
                    state <= 4; // continue digging
                end
            end
        endcase
    end

endmodule
