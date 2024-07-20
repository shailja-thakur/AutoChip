module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

// State definitions
localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

// Next state logic
always @(*) begin
    case (state)
        STATE_A: begin
            if (j) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_A;
            end
        end
        STATE_B: begin
            if (k) begin
                next_state = STATE_A;
            end else begin
                next_state = STATE_B;
            end
        end
        default: begin
            next_state = STATE_A;
        end
    endcase
end

// State update
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_A;
    end else begin
        state <= next_state;
    end
end

// Output logic
always @(*) begin
    if (state == STATE_B) begin
        out = 1'b1;
    end else begin
        out = 1'b0;
    end
end

endmodule
