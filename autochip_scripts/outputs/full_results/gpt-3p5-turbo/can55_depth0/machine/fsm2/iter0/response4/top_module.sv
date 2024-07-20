module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg [1:0] state;

    // combinational always block to determine the next state based on current state and j, k inputs
    always @* begin
        case (state)
            2'b00: state = (j == 1'b1) ? 2'b01 : 2'b00; // State A: If j is high, transition to state B. Otherwise, stay in state A.
            2'b01: state = (k == 1'b1) ? 2'b00 : 2'b01; // State B: If k is high, transition to state A. Otherwise, stay in state B.
            default: state = 2'b00;
        endcase
    end

    // clocked always block to update the value of state based on areset and next state
    always @(posedge clk) begin
        if (areset == 1'b1) begin
            state <= 2'b00; // Reset state to A.
        end else begin
            state <= state;
        end
    end

    // assign out based on current state
    assign out = (state == 2'b01) ? 1'b1 : 1'b0; // If current state is B, out is high. Otherwise, out is low.

endmodule
