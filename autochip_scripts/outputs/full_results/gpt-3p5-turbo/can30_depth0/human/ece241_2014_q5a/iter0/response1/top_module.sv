module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [1:0] state; // Creating a 2-bit state register
reg [1:0] next_state; // Creating a 2-bit register to hold next state

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00; // Resetting the state to 00 on positive edge of asynchronous reset
    end
    else begin
        state <= next_state; // Updating the state to next_state on positive edge of clock
    end
end

always @(state, x) begin
    case (state)
        2'b00: begin // State 0
            next_state = (x == 1'b1) ? 2'b01 : 2'b00; // Transition to state 1 if x == 1, else stay in state 0
            z = 1'b0; // Output z is always 0 in state 0
        end
        2'b01: begin // State 1
            next_state = (x == 1'b0) ? 2'b01 : 2'b10; // Transition to state 1 if x == 0, else transition to state 2
            z = 1'b1; // Output z is always 1 in state 1
        end
        2'b10: begin // State 2
            next_state = 2'b10; // Stay in state 2
            z = ~x; // Output z is the 2's complement of input x in state 2
        end
        default: begin
            next_state = 2'b00;
            z = 1'b0;
        end
    endcase
end

endmodule
