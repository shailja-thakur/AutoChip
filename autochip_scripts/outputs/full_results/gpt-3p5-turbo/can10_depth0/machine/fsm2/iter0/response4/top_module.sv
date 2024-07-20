module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg [1:0] state;
    reg [1:0] next_state;

    always @(*) begin
        case(state)
            2'b00: next_state = j ? 2'b01 : 2'b00; // state A -> next state B (if j is high) or stay in state A
            2'b01: next_state = k ? 2'b00 : 2'b01; // state B -> next state A (if k is high) or stay in state B
            default: next_state = 2'b00; // Default case set next_state to A
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00; // Reset state to A
        else
            state <= next_state;
    end

    assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output high if state is B, otherwise output low

endmodule
