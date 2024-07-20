module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// State declarations
localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

// State register
reg state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_B;
        out <= 1'b1;
    end
    else begin
        case (state)
            STATE_B: begin
                if (in) begin
                    state <= STATE_B;
                    out <= 1'b1;
                end
                else begin
                    state <= STATE_A;
                    out <= 1'b1;
                end
            end
            STATE_A: begin
                if (in) begin
                    state <= STATE_A;
                    out <= 1'b0;
                end
                else begin
                    state <= STATE_B;
                    out <= 1'b0;
                end
            end
            default: begin
                state <= STATE_B;
                out <= 1'b1;
            end
        endcase
    end
end

endmodule
