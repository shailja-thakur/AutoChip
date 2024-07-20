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

reg [1:0] state, next_state;
reg [1:0] x_count;

always @(posedge clk, negedge resetn) begin
    if (~resetn) begin
        state <= STATE_A;
        x_count <= 0;
        f <= 0;
        g <= 0;
    end else begin
        state <= next_state;
        case (state)
            STATE_A: begin
                f <= 0;
                g <= 0;
            end
            STATE_B: begin
                f <= 1;
                g <= 0;
            end
            STATE_C: begin
                g <= 1;
                if (y == 1) begin
                    x_count <= 0;
                end else begin
                    x_count <= x_count + 1;
                end
            end
            STATE_D: begin
                g <= (x_count < 2) ? 1 : 0;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        STATE_A: next_state = (resetn) ? STATE_B : STATE_A;
        STATE_B: next_state = (x == 1) ? STATE_C : STATE_B;
        STATE_C: next_state = (x == 0) ? STATE_C : ((x == 1) ? STATE_D : STATE_C);
        STATE_D: next_state = STATE_D;
    endcase
end

endmodule
