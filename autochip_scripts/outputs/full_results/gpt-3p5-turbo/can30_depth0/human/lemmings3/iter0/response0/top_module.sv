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

    // State declaration
    reg [1:0] state;

    // State encoding
    localparam IDLE = 2'b00;
    localparam FALL = 2'b01;
    localparam DIG = 2'b10;

    // Default state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (ground == 0) begin
                        state <= FALL;
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end else if (dig == 1 && ground == 1) begin
                        state <= DIG;
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 1;
                    end else if (bump_left == 1) begin
                        state <= IDLE;
                        walk_left <= 0;
                        walk_right <= 1;
                        aaah <= 0;
                        digging <= 0;
                    end else if (bump_right == 1) begin
                        state <= IDLE;
                        walk_left <= 1;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end else begin
                        state <= IDLE;
                        walk_left <= 1;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end
                end
                FALL: begin
                    if (ground == 1) begin
                        state <= IDLE;
                        walk_left <= (bump_right == 1);
                        walk_right <= (bump_left == 1);
                        aaah <= 0;
                        digging <= 0;
                    end else begin
                        state <= FALL;
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end
                end
                DIG: begin
                    if (ground == 0) begin
                        state <= FALL;
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end else begin
                        state <= DIG;
                        walk_left <= 0;
                        walk_right <= (dig == 1);
                        aaah <= (dig == 1);
                        digging <= 1;
                    end
                end
                default: state <= IDLE;
            endcase
        end
    end

endmodule
