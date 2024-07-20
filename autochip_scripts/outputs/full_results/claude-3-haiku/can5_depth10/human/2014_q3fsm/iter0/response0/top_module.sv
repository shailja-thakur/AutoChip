module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

localparam STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10;
reg [1:0] state, next_state;
reg [1:0] w_count;

always @(posedge clk) begin
    if (reset)
        state <= STATE_A;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_A: begin
            if (s)
                next_state = STATE_B;
            else
                next_state = STATE_A;
        end
        STATE_B: begin
            if (w_count == 2)
                next_state = STATE_C;
            else
                next_state = STATE_B;
        end
        STATE_C: begin
            next_state = STATE_B;
        end
    endcase
end

always @(posedge clk) begin
    if (reset)
        w_count <= 0;
    else if (state == STATE_B) begin
        if (w)
            w_count <= w_count + 1;
        else
            w_count <= w_count;
    end
    else
        w_count <= 0;
end

always @(posedge clk) begin
    if (reset)
        z <= 0;
    else if (state == STATE_C)
        z <= 1;
    else
        z <= 0;
end

endmodule
