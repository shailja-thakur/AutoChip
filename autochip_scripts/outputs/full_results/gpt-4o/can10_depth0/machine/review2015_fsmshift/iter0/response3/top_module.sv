module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    // State definitions
    typedef enum reg [2:0] {
        B0 = 3'b000,
        B1 = 3'b001,
        B2 = 3'b010,
        B3 = 3'b011,
        Done = 3'b100
    } state_t;
    
    state_t state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B0;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state and shift_ena
    always @(*) begin
        case (state)
            B0: begin
                next_state = B1;
                shift_ena = 1;
            end
            B1: begin
                next_state = B2;
                shift_ena = 1;
            end
            B2: begin
                next_state = B3;
                shift_ena = 1;
            end
            B3: begin
                next_state = Done;
                shift_ena = 1;
            end
            Done: begin
                next_state = Done;
                shift_ena = 0;
            end
            default: begin
                next_state = Done;
                shift_ena = 0;
            end
        endcase
    end

endmodule
