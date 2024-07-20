module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

parameter STATE_A = 0, STATE_B = 1;
reg [0:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_B; // Reset to initial state B
    end
    else begin
        case (state)
            STATE_A: begin
                if (in) begin
                    state <= STATE_A;
                end
                else begin
                    state <= STATE_B;
                end
            end
            STATE_B: begin
                if (in) begin
                    state <= STATE_B;
                end
                else begin
                    state <= STATE_A;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        STATE_B: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
