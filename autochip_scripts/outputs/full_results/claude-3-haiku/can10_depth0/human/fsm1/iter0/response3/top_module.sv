module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

// State definitions
localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

// State register
reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_B;
        out <= 1'b1;
    end
    else begin
        case (state)
            STATE_B: begin
                if (in == 1'b0) begin
                    state <= STATE_A;
                    out <= 1'b0;
                end
                else begin
                    state <= STATE_B;
                    out <= 1'b1;
                end
            end
            STATE_A: begin
                if (in == 1'b0) begin
                    state <= STATE_B;
                    out <= 1'b1;
                end
                else begin
                    state <= STATE_A;
                    out <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
