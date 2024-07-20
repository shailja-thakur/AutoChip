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

    reg [1:0] state;
    wire fall;

    assign fall = (state == 2'b00) & ~ground;
    assign aaah = fall;
    assign walk_left = state[1];
    assign walk_right = ~state[1];

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10;
        end else begin
            case (state)
                2'b00: begin
                    if (fall) begin
                        state <= 2'b01;
                    end else if (bump_left & bump_right) begin
                        state <= 2'b10;
                    end else if (bump_left) begin
                        state <= 2'b10;
                    end else if (bump_right) begin
                        state <= 2'b01;
                    end
                end
                2'b01: begin
                    if (ground) begin
                        state <= 2'b10;
                    end else if (fall) begin
                        state <= 2'b01;
                    end else if (bump_right) begin
                        state <= 2'b01;
                    end else if (bump_left) begin
                        state <= 2'b10;
                    end
                end
                2'b10: begin
                    if (fall) begin
                        state <= 2'b01;
                    end else if (bump_left) begin
                        state <= 2'b10;
                    end else if (bump_right) begin
                        state <= 2'b10;
                    end else if (bump_left & bump_right) begin
                        state <= 2'b10;
                    end
                end
                default: state <= 2'b10;
            endcase
        end
    end

endmodule
