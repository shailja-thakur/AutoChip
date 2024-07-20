module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] current_state, next_state;

localparam [1:0] 
    STATE_A = 2'd0,
    STATE_B = 2'd1,
    STATE_C = 2'd2,
    STATE_D = 2'd3;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_A;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        STATE_A: begin
            if (in) begin
                next_state = STATE_B;
            end
            else begin
                next_state = STATE_A;
            end
            out = 1'b0;
        end
        STATE_B: begin
            if (in) begin
                next_state = STATE_B;
            end
            else begin
                next_state = STATE_C;
            end
            out = 1'b0;
        end
        STATE_C: begin
            if (in) begin
                next_state = STATE_D;
            end
            else begin
                next_state = STATE_A;
            end
            out = 1'b0;
        end
        STATE_D: begin
            if (in) begin
                next_state = STATE_B;
            end
            else begin
                next_state = STATE_C;
            end
            out = 1'b1;
        end
        default: begin
            next_state = STATE_A;
            out = 1'b0;
        end
    endcase
end

endmodule
