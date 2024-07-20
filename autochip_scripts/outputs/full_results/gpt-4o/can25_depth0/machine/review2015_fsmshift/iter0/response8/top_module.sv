module top_module(
    input clk,
    input reset,
    output shift_ena
);

    typedef enum reg [2:0] {
        B0 = 3'b000,
        B1 = 3'b001,
        B2 = 3'b010,
        B3 = 3'b011,
        Done = 3'b100
    } state_t;
    
    state_t state, next_state;
    
    // Current state logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B0;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = Done;
            Done: next_state = Done;
            default: next_state = Done;
        endcase
    end
    
    // Output logic
    assign shift_ena = (state == B0) | (state == B1) | (state == B2) | (state == B3);
    
endmodule
