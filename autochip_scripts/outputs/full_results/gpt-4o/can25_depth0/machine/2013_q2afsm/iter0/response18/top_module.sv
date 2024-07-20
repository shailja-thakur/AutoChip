module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State declaration
    typedef enum reg [1:0] {A, B, C, D} state_t;
    reg state, next_state;

    // State update on the rising edge of the clock
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;  // Reset state to A if resetn is low
        else
            state <= next_state;  // Update state to the next state
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (r[1])
                    next_state = B;
                else if (r[2])
                    next_state = C;
                else if (r[3])
                    next_state = D;
                else
                    next_state = A;
            end
            B: begin
                if (r[1])
                    next_state = B;
                else
                    next_state = A;
            end
            C: begin
                if (r[2])
                    next_state = C;
                else
                    next_state = A;
            end
            D: begin
                if (r[3])
                    next_state = D;
                else
                    next_state = A;
            end
            default: next_state = A;  // Default state is A
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            B: g = 3'b010;
            C: g = 3'b100;
            D: g = 3'b001;
            default: g = 3'b000;  // Default output is all zeros
        endcase
    end

endmodule
