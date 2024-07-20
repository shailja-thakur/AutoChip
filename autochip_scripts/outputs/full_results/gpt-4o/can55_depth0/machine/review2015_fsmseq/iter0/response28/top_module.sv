module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // Define state encoding
    typedef enum reg [2:0] {
        S = 3'b000,
        S1 = 3'b001,
        S11 = 3'b010,
        S110 = 3'b011,
        Done = 3'b100
    } state_t;
    
    // State variable
    state_t state, next_state;

    // Sequential logic to update state on rising edge of clk or reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S;  // Initialize to state S on reset
        end else begin
            state <= next_state;  // Update to the next state
        end
    end

    // Combinational logic to determine next state based on current state and data input
    always @(*) begin
        case (state)
            S: begin
                if (data) next_state = S1;
                else next_state = S;
            end
            
            S1: begin
                if (data) next_state = S11;
                else next_state = S;
            end
            
            S11: begin
                if (data) next_state = S11;
                else next_state = S110;
            end
            
            S110: begin
                if (data) next_state = Done;
                else next_state = S;
            end
            
            Done: begin
                next_state = Done;  // Stay in Done state
            end
            
            default: next_state = S;  // Default state
        endcase
    end

    // Output logic based on the current state
    always @(*) begin
        start_shifting = (state == Done);  // Output high if in state Done, low otherwise
    end

endmodule
