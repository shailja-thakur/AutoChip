module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

parameter STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10;
reg [1:0] state, next_state;
reg [1:0] w_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_A;
        w_count <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        if (state == STATE_B) begin
            if (w_count == 2) begin
                z <= 1;
            end
            else begin
                z <= 0;
            end
        end
    end
end

always @(*) begin
    case (state)
        STATE_A: begin
            if (s == 1) begin
                next_state = STATE_B;
                w_count = 0;
            end
            else begin
                next_state = STATE_A;
                w_count = 0;
            end
        end
        STATE_B: begin
            if (w == 1) begin
                w_count = w_count + 1;
            end
            if (w_count == 3) begin
                next_state = STATE_B;
                w_count = 0;
            end
            else begin
                next_state = STATE_B;
            end
        end
        default: begin
            next_state = STATE_A;
            w_count = 0;
        end
    endcase
end

endmodule
