module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;

reg [1:0] current_state, next_state;
reg [1:0] w_count;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_A;
        w_count <= 0;
        z <= 0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    next_state = current_state;
    case (current_state)
        STATE_A:
            if (s) begin
                next_state = STATE_B;
            end
        STATE_B:
            if (w_count == 2) begin
                next_state = STATE_C;
                z = 1;
            end
            else begin
                next_state = STATE_B;
                z = 0;
            end
        STATE_C:
            if (w_count == 0) begin
                next_state = STATE_B;
                w_count = 0;
            end
            else begin
                next_state = STATE_C;
                w_count = w_count - 1;
            end
    endcase
end

always @(posedge clk) begin
    if (current_state == STATE_B) begin
        w_count <= w_count + (w ? 1 : 0);
    end
end

endmodule
