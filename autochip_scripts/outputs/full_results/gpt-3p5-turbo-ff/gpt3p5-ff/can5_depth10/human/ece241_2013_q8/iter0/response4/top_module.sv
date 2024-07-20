module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the states
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

// Define the state register
reg [1:0] state;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= S0;  // Reset the state to S0
        z <= 0;  // Reset the output signal
    end else begin
        case (state)
            S0: begin
                if (x) begin
                    state <= S1;  // Transition to S1 if input x is 1
                end
            end
            S1: begin
                if (!x) begin
                    state <= S2;  // Transition to S2 if input x is 0
                end else begin
                    state <= S1;  // Stay in S1 if input x is 1
                end
            end
            S2: begin
                if (x) begin
                    state <= S1;  // Transition back to S1 if input x is 1
                    z <= 1;  // Assert the output signal when "101" sequence is detected
                end else begin
                    state <= S0;  // Transition back to S0 if input x is 0
                end
            end
        endcase
    end
end

endmodule
