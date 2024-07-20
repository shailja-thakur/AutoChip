module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg current_state, next_state;
parameter STATE_A = 1'b0, STATE_B = 1'b1;

// Combinational logic to determine the next state
always @(*) begin
    case (current_state)
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

// Sequential logic to update the current state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= STATE_A;
    end else begin
        current_state <= next_state;
    end
end

// Combinational logic to set the output
always @(*) begin
    if (current_state == STATE_B) begin
        out = 1'b1;
    end else begin
        out = 1'b0;
    end
end

endmodule
