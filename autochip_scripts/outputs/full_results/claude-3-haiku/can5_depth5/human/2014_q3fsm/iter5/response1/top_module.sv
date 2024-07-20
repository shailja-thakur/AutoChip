module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

localparam STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10;
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
        case (current_state)
            STATE_A: begin
                if (s) begin
                    next_state <= STATE_B;
                    w_count <= 0;
                end
                else begin
                    next_state <= STATE_A;
                    w_count <= 0;
                end
                z <= 0;
            end
            STATE_B: begin
                if (w) begin
                    w_count <= w_count + 1;
                end
                if (w_count == 2) begin
                    next_state <= STATE_A;
                    z <= 1;
                end
                else if (w_count == 3) begin
                    next_state <= STATE_A;
                    w_count <= 0;
                    z <= 0;
                end
                else begin
                    next_state <= STATE_B;
                    z <= 0;
                end
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
