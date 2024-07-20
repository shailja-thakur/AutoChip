module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

localparam STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10;
reg [1:0] state, next_state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_A;
        count <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        if (state == STATE_B) begin
            if (count == 2) begin
                z <= 1;
            end
            else begin
                z <= 0;
            end
            count <= count + 1;
            if (count == 3) begin
                count <= 0;
            end
        end
    end
end

always @(*) begin
    case (state)
        STATE_A: begin
            if (s == 1) begin
                next_state = STATE_B;
            end
            else begin
                next_state = STATE_A;
            end
        end
        STATE_B: begin
            if (w == 1) begin
                next_state = STATE_C;
            end
            else begin
                next_state = STATE_B;
            end
        end
        STATE_C: begin
            if (w == 1) begin
                next_state = STATE_B;
            end
            else begin
                next_state = STATE_B;
            end
        end
        default: begin
            next_state = STATE_A;
        end
    endcase
end

endmodule
