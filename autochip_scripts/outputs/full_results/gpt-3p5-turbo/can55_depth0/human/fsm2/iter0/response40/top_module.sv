module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

// States
parameter OFF = 0;
parameter ON = 1;

// State register
reg [1:0] state;

// Next state logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= OFF;
    end else begin
        case(state)
            OFF: begin
                if (j) begin
                    state <= ON;
                end else begin
                    state <= OFF;
                end
            end
            ON: begin
                if (k) begin
                    state <= OFF;
                end else begin
                    state <= ON;
                end
            end
        endcase
    end
end

// Output logic
always @(state) begin
    case(state)
        OFF: begin
            out <= 0;
        end
        ON: begin
            out <= 1;
        end
    endcase
end

endmodule
