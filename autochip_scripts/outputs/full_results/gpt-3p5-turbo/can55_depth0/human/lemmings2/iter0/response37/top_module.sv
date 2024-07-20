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

    reg [1:0] state;  // state variable

    // Outputs
    assign walk_left = (state == 2'b01);
    assign walk_right = (state == 2'b10);
    assign aaah = (state == 2'b00);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;  // Initialize state to walking left
        end
        else begin
            case (state)
                2'b00: begin  // State: Falling
                    if (ground) begin
                        if (bump_left || bump_right) begin
                            state <= 2'b11;  // State: Change direction
                        end
                        else begin
                            state <= 2'b01;  // State: Walking left
                        end
                    end
                end
                2'b01: begin  // State: Walking left
                    if (bump_right) begin
                        state <= 2'b10;  // State: Change direction (walk right)
                    end
                    else if (!ground) begin
                        state <= 2'b00;  // State: Falling
                    end
                end
                2'b10: begin  // State: Walking right
                    if (bump_left) begin
                        state <= 2'b01;  // State: Change direction (walk left)
                    end
                    else if (!ground) begin
                        state <= 2'b00;  // State: Falling
                    end
                end
                2'b11: begin  // State: Change direction
                    state <= 2'b00;  // State: Falling
                end
                default: state <= 2'b01;  // Default state: Walking left
            endcase
        end
    end

endmodule
