module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

localparam STATE_A = 2'd0;
localparam STATE_B = 2'd1;
localparam STATE_C = 2'd2;
localparam STATE_D = 2'd3;

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
                if (w) begin
                    w_count <= w_count + 1;
                end
                if (w_count == 2) begin
                    next_state <= STATE_C;
                end
                else begin
                    next_state <= STATE_B;
                end
                z <= 0;
            end
            STATE_C: begin
                z <= 1;
                next_state <= STATE_D;
            end
            STATE_D: begin
                if (w) begin
                    w_count <= w_count + 1;
                end
                else begin
                    w_count <= 0;
                end
                if (w_count == 2) begin
                    next_state <= STATE_C;
                end
                else begin
                    next_state <= STATE_D;
                end
                z <= 0;
            end
        endcase
    end
end

endmodule
