module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

parameter STATE_A = 2'd0;
parameter STATE_B = 2'd1;
parameter STATE_C = 2'd2;
parameter STATE_D = 2'd3;

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
        case (state)
            STATE_A: begin
                if (s) begin
                    next_state <= STATE_B;
                end
                else begin
                    next_state <= STATE_A;
                end
                w_count <= 0;
                z <= 0;
            end
            STATE_B: begin
                next_state <= STATE_C;
                w_count <= 0;
                z <= 0;
            end
            STATE_C: begin
                next_state <= STATE_D;
                w_count <= w_count + (w ? 1 : 0);
                z <= 0;
            end
            STATE_D: begin
                next_state <= STATE_B;
                if (w_count == 2) begin
                    z <= 1;
                end
                else begin
                    z <= 0;
                end
                w_count <= 0;
            end
            default: begin
                next_state <= STATE_A;
                w_count <= 0;
                z <= 0;
            end
        endcase
    end
end

endmodule
