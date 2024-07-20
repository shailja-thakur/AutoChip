module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    enum logic [3:0] states;
    reg [3:0] current_state, next_state;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            current_state <= 0;
            f <= 0;
            g <= 0;
        end else begin
            current_state <= next_state;
            case (current_state)
                0: begin
                    if (x) next_state = 1;
                    else next_state = 0;
                    f <= 0;
                    g <= 0;
                end
                1: begin
                    if (x) next_state = 1;
                    else next_state = 2;
                    f <= 0;
                    g <= 0;
                end
                2: begin
                    if (x) next_state = 3;
                    else next_state = 0;
                    f <= 0;
                    g <= 0;
                end
                3: begin
                    if (y) next_state = 4;
                    else next_state = 5;
                    f <= 0;
                    g <= 0;
                end
                4: begin
                    if (y) next_state = 6;
                    else next_state = 7;
                    f <= 1;
                    g <= 1;
                end
                5: begin
                    if (y) next_state = 7;
                    else next_state = 9;
                    f <= 0;
                    g <= 0;
                end
                6: begin
                    if (y) next_state = 6;
                    else next_state = 9;
                    f <= 1;
                    g <= 1;
                end
                7: begin
                    if (y) next_state = 7;
                    else next_state = 8;
                    f <= 1;
                    g <= 1;
                end
                8: begin
                    next_state = 8;
                    f <= 1;
                    g <= 1;
                end
                9: begin
                    next_state = 9;
                    f <= 1;
                    g <= 1;
                end
                default: begin
                    next_state = 0;
                    f <= 0;
                    g <= 0;
                end
            endcase
        end
    end

endmodule
