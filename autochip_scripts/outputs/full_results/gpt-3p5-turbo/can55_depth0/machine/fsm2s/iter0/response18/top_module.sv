module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg state, next_state;

// Initialize state to A
initial begin
    state = 1'b0;
end

// State transition and output logic
always @(posedge clk, negedge reset) begin
    if (reset)
        state <= 1'b0; // State A
    else begin
        case (state)
            1'b0: begin // State A
                if (j)
                    next_state = 1'b1;
                else
                    next_state = 1'b0;
            end
            1'b1: begin // State B
                if (k)
                    next_state = 1'b0;
                else
                    next_state = 1'b1;
            end
        endcase
        state <= next_state;
    end
end

// Assign output based on state
always @(state) begin
    if (state)
        out = 1'b1; // State B
    else
        out = 1'b0; // State A
end

endmodule
