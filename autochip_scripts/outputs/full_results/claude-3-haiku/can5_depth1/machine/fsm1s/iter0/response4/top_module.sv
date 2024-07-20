module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    parameter STATE_A = 1'b0, STATE_B = 1'b1;
    reg state;

    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_B;
        end else begin
            case (state)
                STATE_A: state <= (in) ? STATE_A : STATE_B;
                STATE_B: state <= (in) ? STATE_B : STATE_A;
            endcase
        end
    end

    always @(*) begin
        out = (state == STATE_B);
    end

endmodule
