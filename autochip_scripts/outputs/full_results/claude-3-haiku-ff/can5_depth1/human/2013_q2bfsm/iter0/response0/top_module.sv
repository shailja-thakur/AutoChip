module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

reg [1:0] current_state, next_state;
reg x_history [2:0];

always @(posedge clk) begin
    if (!resetn) begin
        current_state <= STATE_A;
        f <= 0;
        g <= 0;
        x_history <= 3'b000;
    end
    else begin
        current_state <= next_state;
        x_history <= {x_history[1:0], x};
        case (current_state)
            STATE_A: begin
                f <= 0;
                g <= 0;
            end
            STATE_B: begin
                f <= 1;
                g <= 0;
            end
            STATE_C: begin
                f <= 0;
                if (x_history == 3'b101 && y == 1) begin
                    g <= 1;
                end
                else if (x_history == 3'b101 && y == 0) begin
                    g <= 0;
                end
            end
            STATE_D: begin
                f <= 0;
                g <= 1;
            end
        endcase
    end
end

always @(*) begin
    case (current_state)
        STATE_A: next_state = resetn ? STATE_B : STATE_A;
        STATE_B: next_state = STATE_C;
        STATE_C: begin
            if (x_history == 3'b101) begin
                next_state = (y == 1) ? STATE_D : STATE_C;
            end
            else begin
                next_state = STATE_C;
            end
        end
        STATE_D: next_state = STATE_D;
    endcase
end

endmodule
