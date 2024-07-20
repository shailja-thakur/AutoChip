module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state; // Declare state variable

// Define state machine states
parameter OFF = 0;
parameter ON = 1;

// Define state machine transitions and output
always @(posedge clk) begin
    if (reset) begin
        state <= OFF; // Reset state to OFF
    end else begin
        case(state)
            OFF: begin
                if (j) begin
                    state <= ON; // Transition to ON when j=1
                end else begin
                    state <= OFF; // Stay in OFF when j=0
                end
                out <= 0; // Output is 0 when in OFF state
            end
            ON: begin
                if (k) begin
                    state <= OFF; // Transition to OFF when k=1
                end else begin
                    state <= ON; // Stay in ON when k=0
                end
                out <= 1; // Output is 1 when in ON state
            end
            default: state <= OFF;
        endcase
    end
end

endmodule
