module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

localparam STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10, STATE_D = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_A;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        STATE_A: begin
            out = 1'b0;
            next_state = (in) ? STATE_B : STATE_A;
        end
        STATE_B: begin
            out = 1'b0;
            next_state = (in) ? STATE_B : STATE_C;
        end
        STATE_C: begin
            out = 1'b0;
            next_state = (in) ? STATE_D : STATE_A;
        end
        STATE_D: begin
            out = 1'b1;
            next_state = (in) ? STATE_B : STATE_C;
        end
        default: begin
            out = 1'b0;
            next_state = STATE_A;
        end
    endcase
end

endmodule
