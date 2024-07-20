module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output aaah
);

    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10; // walking left
        end else begin
            case (state)
                2'b10: begin // walking left
                    if (bump_right) begin
                        state <= 2'b01; // walking right
                    end else if (bump_left) begin
                        state <= 2'b10; // walking left
                    end else if (ground == 0) begin
                        state <= 2'b11; // falling
                    end
                end
                2'b01: begin // walking right
                    if (bump_left) begin
                        state <= 2'b10; // walking left
                    end else if (bump_right) begin
                        state <= 2'b01; // walking right
                    end else if (ground == 0) begin
                        state <= 2'b11; // falling
                    end
                end
                2'b11: begin // falling
                    if (ground == 1) begin
                        if (state == 2'b10) begin
                            state <= 2'b10; // walking left
                        end else if (state == 2'b01) begin
                            state <= 2'b01; // walking right
                        end
                    end
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            2'b10: begin // walking left
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
            2'b01: begin // walking right
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end
            2'b11: begin // falling
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
        endcase
    end

endmodule
