module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

reg state;
reg next_state;

// State machine logic
always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case(state)
        A: begin
            if (j) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (k) begin
                next_state = A;
            end else begin
                next_state = B;
            end
        end
        default: begin
            next_state = A;
        end
    endcase
end

// Output logic
assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
