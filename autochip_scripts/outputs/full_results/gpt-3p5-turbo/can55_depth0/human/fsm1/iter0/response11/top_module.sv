module top_module (
    input clk,
    input in,
    input areset,
    output out
);

// State enum definition
typedef enum logic [1:0] {
    S_B,
    S_A
} state_t;

reg state, next_state;

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= S_B;
    end else begin
        state <= next_state;
    end
end

always_comb begin
    case (state)
        S_B: begin
            case (in)
                1'b0: next_state = S_A;
                1'b1: next_state = S_B;
            endcase
        end
        S_A: begin
            case (in)
                1'b0: next_state = S_B;
                1'b1: next_state = S_A;
            endcase
        end
        default: next_state = S_B;
    endcase
end

assign out = (state == S_A) ? 1'b1 : 1'b0;

endmodule
