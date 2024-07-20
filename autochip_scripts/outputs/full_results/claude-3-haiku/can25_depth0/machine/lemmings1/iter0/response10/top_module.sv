module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Parameters for the two states
parameter WL = 1'd0;
parameter WR = 1'd1;

// Register to hold the current state
reg state;

// Combinational logic to determine the next state
always @(*) begin
    case (state)
        WL: begin
            if (bump_left) begin
                state = WR;
            end else begin
                state = WL;
            end
        end
        WR: begin
            if (bump_right) begin
                state = WL;
            end else begin
                state = WR;
            end
        end
        default: begin
            state = WL;
        end
    endcase
end

// Sequential logic to update the state on the rising edge of the clock
// and reset the state to the initial state on the rising edge of the reset signal
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WL;
    end else begin
        state <= state;
    end
end

// Assign the walk_left and walk_right outputs based on the current state
always @(*) begin
    if (state == WL) begin
        walk_left = 1'b1;
        walk_right = 1'b0;
    end else begin
        walk_left = 1'b0;
        walk_right = 1'b1;
    end
end

endmodule
