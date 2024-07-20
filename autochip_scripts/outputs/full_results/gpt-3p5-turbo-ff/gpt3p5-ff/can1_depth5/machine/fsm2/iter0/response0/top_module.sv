module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg state, next_state; // define state and next_state as registers

    // combinational logic to determine next_state based on current state and inputs j and k
    always @*
    begin
        case (state)
            A: next_state = (j == 1'b1) ? B : A;
            B: next_state = (k == 1'b1) ? A : B;
        endcase
    end

    // clocked always block to update state based on areset and next_state
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= A; // reset to state A
        else
            state <= next_state; // update state to next_state
    end

    // assign out to be high if state is B, low otherwise
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
