module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

// Define the states
localparam STATE_OFF = 1'b0;
localparam STATE_ON = 1'b1;

// Define the state register
reg state;

// Reset logic
always @(posedge clk) begin
    if (reset)
        state <= STATE_OFF;
    else begin
        case (state)
            STATE_OFF: begin
                if (j)
                    state <= STATE_ON;
                else
                    state <= STATE_OFF;
            end
            STATE_ON: begin
                if (k)
                    state <= STATE_OFF;
                else
                    state <= STATE_ON;
            end
        endcase
    end
end

// Output logic
always @(posedge clk) begin
    if (reset)
        out <= 1'b0;
    else
        out <= (state == STATE_ON) ? 1'b1 : 1'b0;
end

endmodule
