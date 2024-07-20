module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10; // Walking left state
        end else begin
            case (state)
                2'b00: begin // Falling state
                    if (ground) begin
                        state <= 2'b01; // Walking state
                        if (walk_left) begin
                            walk_right <= 0;
                        end else begin
                            walk_right <= 1;
                        end
                    end else begin
                        if (dig) begin
                            state <= 2'b11; // Digging state
                        end else begin
                            state <= 2'b00; // Falling state
                        end
                    end
                end
                2'b01: begin // Walking state
                    if (ground) begin
                        state <= 2'b01; // Walking state
                        if (bump_left) begin
                            walk_left <= 0;
                            walk_right <= 1;
                        end else if (bump_right) begin
                            walk_left <= 1;
                            walk_right <= 0;
                        end else begin
                            walk_left <= walk_left;
                            walk_right <= walk_right;
                        end
                    end else begin
                        state <= 2'b00; // Falling state
                    end
                end
                2'b10: begin // Walking left state
                    if (ground) begin
                        state <= 2'b10; // Walking left state
                        if (bump_right) begin
                            walk_left <= 1;
                            walk_right <= 0;
                        end else begin
                            walk_left <= walk_left;
                            walk_right <= walk_right;
                        end
                    end else begin
                        state <= 2'b00; // Falling state
                    end
                end
                2'b11: begin // Digging state
                    if (ground && !dig) begin
                        state <= 2'b01; // Walking state
                        if (walk_left) begin
                            walk_right <= 0;
                        end else begin
                            walk_right <= 1;
                        end
                        digging <= 0;
                    end else begin
                        state <= 2'b11; // Digging state
                        digging <= 1;
                    end
                end
                default: state <= 2'b10;
            endcase
        end
    end

    always @(posedge clk) begin
        aaah <= (state == 2'b00) ? 1 : 0;
    end

endmodule
