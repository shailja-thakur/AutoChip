module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

reg [1:0] current_state, next_state;

always @(posedge clk) begin
    if (reset)
        current_state <= STATE_A;
    else
        current_state <= next_state;
end

always @(*) begin
    case (current_state)
        STATE_A: begin
            if (in)
                next_state = STATE_B;
            else
                next_state = STATE_A;
            out = 1'b0;
        end
        STATE_B: begin
            if (in)
                next_state = STATE_B;
            else
                next_state = STATE_C;
            out = 1'b0;
        end
        STATE_C: begin
            if (in)
                next_state = STATE_D;
            else
                next_state = STATE_A;
            out = 1'b0;
        end
        STATE_D: begin
            if (in)
                next_state = STATE_B;
            else
                next_state = STATE_C;
            out = 1'b1;
        end
        default: begin
            next_state = STATE_A;
            out = 1'b0;
        end
    endcase
end

endmodule
