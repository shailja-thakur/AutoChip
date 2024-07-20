module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

parameter STATE_A = 2'b00;
parameter STATE_B = 2'b01;
parameter STATE_C = 2'b10;

reg [1:0] state, next_state;
reg [1:0] w_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_A;
        w_count <= 2'b00;
        z <= 1'b0;
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
            end
            STATE_B: begin
                if (w) begin
                    w_count <= w_count + 1;
                end
                if (w_count == 2'b10) begin
                    z <= 1'b1;
                end
                else begin
                    z <= 1'b0;
                end
                next_state <= STATE_C;
            end
            STATE_C: begin
                if (w) begin
                    w_count <= w_count + 1;
                end
                if (w_count == 2'b10) begin
                    z <= 1'b1;
                end
                else begin
                    z <= 1'b0;
                end
                next_state <= STATE_A;
            end
        endcase
    end
end

endmodule
