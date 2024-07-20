module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// State encoding
typedef enum reg [2:0] {
    S = 3'b000,
    S1 = 3'b001,
    S11 = 3'b010,
    S110 = 3'b011,
    Done = 3'b100
} state_t;

// State registers
reg [2:0] current_state, next_state;

// State transition logic (combinational logic block)
always @(*) begin
    // Set the default next state
    next_state = current_state;
    
    case (current_state)
        S: begin
            if (data)
                next_state = S1;
            else
                next_state = S;
        end
        S1: begin
            if (data)
                next_state = S11;
            else
                next_state = S;
        end
        S11: begin
            if (data)
                next_state = S11;
            else
                next_state = S110;
        end
        S110: begin
            if (data)
                next_state = Done;
            else
                next_state = S;
        end
        Done: begin
            next_state = Done;
        end
        default: begin
            next_state = S; // Go to initial state in case of an undefined state
        end
    endcase
end

// State update logic (sequential logic)
always @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= S;
    else
        current_state <= next_state;
end

// Output logic based on state
always @(*) begin
    case (current_state)
        Done: start_shifting = 1;
        default: start_shifting = 0;
    endcase
end

endmodule
