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
localparam STATE_D = 2'b11;

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
            if (w) begin
                w_count <= w_count + 1;
            end
            else begin
                w_count <= 0;
            end
        end
        else if (state == STATE_D) begin
            z <= (w_count == 2);
            w_count <= 0;
        end
    end
end

always @(*) begin
    case (state)
        STATE_A: begin
            if (s) begin
                next_state = STATE_B;
            end
            else begin
                next_state = STATE_A;
            end
        end
        STATE_B: begin
            next_state = STATE_C;
        end
        STATE_C: begin
            next_state = STATE_D;
        end
        STATE_D: begin
            next_state = STATE_B;
        end
        default: begin
            next_state = STATE_A;
        end
    endcase
end

endmodule
