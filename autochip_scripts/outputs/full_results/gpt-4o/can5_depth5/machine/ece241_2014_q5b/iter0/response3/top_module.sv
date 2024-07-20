module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Define states
    parameter A = 1'b0, B = 1'b1;

    // Register to hold the current state of the state machine
    reg state, next_state;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                    z = 1;
                end else begin
                    next_state = A;
                    z = 0;
                end
            end
            B: begin
                next_state = B;
                if (x) 
                    z = 0;
                else 
                    z = 1;
            end
            default: begin
                next_state = A;
                z = 0;
            end
        endcase
    end
endmodule
