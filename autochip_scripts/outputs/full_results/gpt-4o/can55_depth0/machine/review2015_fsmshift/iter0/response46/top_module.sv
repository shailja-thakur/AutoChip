module top_module(
    input clk,
    input reset,
    output reg shift_ena
);
    // Define state parameters
    parameter B0 = 3'b000;
    parameter B1 = 3'b001;
    parameter B2 = 3'b010;
    parameter B3 = 3'b011;
    parameter Done = 3'b100;
    
    // State register
    reg [2:0] state, next_state;
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B0;
        else
            state <= next_state;
    end
    
    // Next state logic and output logic
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
            default: begin
                next_state = Done;
                shift_ena = 0;
            end
        endcase
    end
    
endmodule
