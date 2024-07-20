module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states of the state machine
parameter S = 0, S1 = 1, S11 = 2, S110 = 3, Done = 4;

// Register to store the current state
reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        // Reset the state to the initial state
        state <= S;
    end
    else begin
        // Transition to the next state based on the current state and data input
        case (state)
            S: begin
                if (data) begin
                    state <= S1;
                end
                else begin
                    state <= S;
                end
            end
            S1: begin
                if (data) begin
                    state <= S11;
                end
                else begin
                    state <= S;
                end
            end
            S11: begin
                if (data) begin
                    state <= S11;
                end
                else begin
                    state <= S110;
                end
            end
            S110: begin
                if (data) begin
                    state <= Done;
                end
                else begin
                    state <= S;
                end
            end
            Done: begin
                state <= Done;
            end
            default: begin
                state <= S;
            end
        endcase
    end
end

// Assign the output based on the current state
always @(*) begin
    case (state)
        Done: start_shifting = 1'b1;
        default: start_shifting = 1'b0;
    endcase
end

endmodule
