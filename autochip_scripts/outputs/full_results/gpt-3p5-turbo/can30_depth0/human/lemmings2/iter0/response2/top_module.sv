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

    reg [1:0] state; // state register

    // output assignments
    assign walk_left = (state == 2'b00); // walking left when state is 00
    assign walk_right = (state == 2'b01); // walking right when state is 01
    assign aaah = (state == 2'b10); // aaah when state is 10

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // reset state to walking left
        end else begin
            case(state)
                2'b00: begin // walking left state
                    if (bump_right && ~bump_left && ground) begin
                        state <= 2'b01; // switch to walking right when bumped on the right and ground appears
                    end else if (ground == 0) begin
                        state <= 2'b10; // switch to aaah state when ground disappears
                    end
                    // else stay in walking left state
                end
                2'b01: begin // walking right state
                    if (bump_left && ~bump_right && ground) begin
                        state <= 2'b00; // switch to walking left when bumped on the left and ground appears
                    end else if (ground == 0) begin
                        state <= 2'b10; // switch to aaah state when ground disappears
                    end
                    // else stay in walking right state
                end
                2'b10: begin // aaah state
                    if (ground) begin
                        state <= (bump_left || bump_right) ? 2'b01 : 2'b00; // switch back to walking state based on bumps
                    end
                    // else stay in aaah state
                end
            endcase
        end
    end
endmodule
