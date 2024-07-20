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

// State transitions
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= OFF;
    end
    else begin
        case (state)
            OFF: begin
                if (j) begin
                    state <= ON;
                end
                else begin
                    state <= OFF;
                end
            end
            ON: begin
                if (k) begin
                    state <= OFF;
                end
                else begin
                    state <= ON;
                end
            end
            default: begin
                state <= OFF;
            end
        endcase
    end
end

// Output logic
always @(*) begin
    case (state)
        OFF: begin
            out = 1'b0;
        end
        ON: begin
            out = 1'b1;
        end
        default: begin
            out = 1'b0;
        end
    endcase
end

endmodule
