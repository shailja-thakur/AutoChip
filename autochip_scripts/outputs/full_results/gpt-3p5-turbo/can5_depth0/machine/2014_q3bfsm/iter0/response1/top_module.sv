module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state, next_state;

    always @(posedge clk) begin
        if (reset)
            state <= 3'b000; // Initializing the state to A
        else
            state <= next_state;
    end

    always @(state, x) begin
        case (state)
            3'b000: // A state
                if (x)
                    next_state = 3'b001; // Next state is B
                else
                    next_state = 3'b000; // Next state is A
            3'b001: // B state
                if (x)
                    next_state = 3'b100; // Next state is E
                else
                    next_state = 3'b001; // Next state is B
            3'b010: // C state
                if (x)
                    next_state = 3'b001; // Next state is B
                else
                    next_state = 3'b010; // Next state is C
            3'b011: // D state
                if (x)
                    next_state = 3'b010; // Next state is C
                else
                    next_state = 3'b001; // Next state is B
            3'b100: // E state
                if (x)
                    next_state = 3'b100; // Next state is E
                else
                    next_state = 3'b011; // Next state is D
            default:
                next_state = 3'b000;
        endcase
    end

    always @(state) begin
        case (state)
            3'b010, 3'b011, 3'b100: // C, D, and E states
                z = 1'b1; // Output is high
            default:
                z = 1'b0; // Output is low
        endcase
    end

endmodule
