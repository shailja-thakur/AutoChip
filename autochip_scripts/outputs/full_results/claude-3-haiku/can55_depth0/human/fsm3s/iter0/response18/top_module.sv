module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State definitions
    localparam STATE_A = 2'd0;
    localparam STATE_B = 2'd1;
    localparam STATE_C = 2'd2;
    localparam STATE_D = 2'd3;

    reg [1:0] state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            STATE_A: begin
                next_state = (in) ? STATE_B : STATE_A;
                out = 1'b0;
            end
            STATE_B: begin
                next_state = (in) ? STATE_B : STATE_C;
                out = 1'b0;
            end
            STATE_C: begin
                next_state = (in) ? STATE_D : STATE_A;
                out = 1'b0;
            end
            STATE_D: begin
                next_state = (in) ? STATE_B : STATE_C;
                out = 1'b1;
            end
            default: begin
                next_state = STATE_A;
                out = 1'b0;
            end
        endcase
    end

endmodule
