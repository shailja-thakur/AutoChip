module top_module (
    input clk,
    input in,
    input reset,
    output out
);

// Define the states
typedef enum logic [1:0] {
    A,
    B,
    C,
    D
} state_t;

// Declare and initialize the state register
reg state_t current_state = A;

// Declare the next state variable
reg state_t next_state;

// Declare the output register
reg out_reg;

// Next state logic and output logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset to state A
        current_state <= A;
    end else begin
        // Determine the next state and output based on the current state and input
        case (current_state)
            A: begin
                if (in) begin
                    next_state <= B;
                end else begin
                    next_state <= A;
                end
                out_reg <= 0;
            end
            B: begin
                if (in) begin
                    next_state <= B;
                end else begin
                    next_state <= C;
                end
                out_reg <= 0;
            end
            C: begin
                if (in) begin
                    next_state <= D;
                end else begin
                    next_state <= A;
                end
                out_reg <= 0;
            end
            D: begin
                if (in) begin
                    next_state <= B;
                end else begin
                    next_state <= C;
                end
                out_reg <= 1;
            end
            default: next_state <= A;
        endcase
    end
end

// Synchronous assignment of the current state
always @(posedge clk) begin
    current_state <= next_state;
end

// Output assignment
assign out = out_reg;

endmodule
