module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

// State encoding
localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_B;
        out <= 1'b1;
    end
    else begin
        case (state)
            STATE_B: begin
                if (in)
                    state <= STATE_B;
                else
                    state <= STATE_A;
                out <= 1'b1;
            end
            STATE_A: begin
                if (in)
                    state <= STATE_A;
                else
                    state <= STATE_B;
                out <= 1'b0;
            end
        endcase
    end
end

endmodule
