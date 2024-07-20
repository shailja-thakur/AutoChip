module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

// State variables
reg state;
parameter OFF = 1'b0, ON = 1'b1;

// Update state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= OFF;
    end
    else begin
        case (state)
            OFF: begin
                if (j) state <= ON;
                else state <= OFF;
            end
            ON: begin
                if (k) state <= OFF;
                else state <= ON;
            end
        endcase
    end
end

// Output logic
always @(*) begin
    case (state)
        OFF: out = 1'b0;
        ON: out = 1'b1;
    endcase
end

endmodule
