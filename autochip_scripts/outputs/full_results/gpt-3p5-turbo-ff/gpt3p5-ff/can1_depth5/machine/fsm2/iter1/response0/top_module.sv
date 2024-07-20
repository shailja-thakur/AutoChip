module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg [1:0] state, next_state; // define state and next_state as 2-bit registers

    // combinational logic to determine next_state based on current state and inputs j and k
    always @*
    begin
        case (state)
            2'b00: next_state = (j == 1'b1) ? 2'b01 : 2'b00; // state A
            2'b01: next_state = (k == 1'b1) ? 2'b00 : 2'b01; // state B
            default: next_state = 2'b00; // default to state A
        endcase
    end

    // clocked always block to update state based on areset and next_state
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= 2'b00; // reset to state A
        else
            state <= next_state; // update state to next_state
    end

    // assign out to be high if state is B, low otherwise
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
