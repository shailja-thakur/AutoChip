module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

reg [1:0] state, next_state; // Define a 2-bit register to store the current state and next state

parameter OFF = 2'b00; // Define the states
parameter ON = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset) begin // Asynchronous reset
        state <= OFF;
    end else begin
        state <= next_state; // Update the current state using the next_state
    end
end

always @(state, j, k) begin
    case (state) // State transition logic
        OFF: begin
            if (j) begin // Transition to ON state if j=1
                next_state = ON;
            end else begin // Stay in OFF state if j=0
                next_state = OFF;
            end
        end
        ON: begin
            if (k) begin // Transition to OFF state if k=1
                next_state = OFF;
            end else begin // Stay in ON state if k=0
                next_state = ON;
            end
        end
        default: next_state = OFF; // Default state
    endcase
end

assign out = (state == ON) ? 1'b1 : 1'b0; // Output is 1 when in ON state, otherwise 0

endmodule
