module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

parameter STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10;
reg [1:0] current_state, next_state;
reg [1:0] w_count;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_A;
        w_count <= 2'b00;
        z <= 1'b0;
    end
    else begin
        current_state <= next_state;
        case (current_state)
            STATE_A: begin
                if (s) begin
                    next_state <= STATE_B;
                    w_count <= 2'b00;
                end
                else begin
                    next_state <= STATE_A;
                    w_count <= 2'b00;
                end
                z <= 1'b0;
            end
            STATE_B: begin
                if (w) begin
                    w_count <= w_count + 1;
                end
                if (w_count == 2'b10) begin
                    next_state <= STATE_C;
                    z <= 1'b1;
                end
                else if (w_count == 2'b11) begin
                    next_state <= STATE_A;
                    z <= 1'b0;
                end
            end
            STATE_C: begin
                next_state <= STATE_A;
                w_count <= 2'b00;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
