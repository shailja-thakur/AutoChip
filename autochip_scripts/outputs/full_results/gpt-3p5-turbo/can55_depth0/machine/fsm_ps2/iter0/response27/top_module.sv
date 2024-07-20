module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // Define states using an enumerated data type
    typedef enum logic [1:0] {
        BYTE1,
        BYTE2,
        BYTE3,
        DONE
    } state_t;

    // Declare state and next_state variables
    state_t state, next_state;

    // Declare register for holding the third bit of the input
    reg third_bit;

    // Assign initial state
    assign state = BYTE1;

    // Sequential logic process
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Combinational logic process
    always @* begin
        third_bit = in[2];
        
        // Determine next state based on current state and input
        case (state)
            BYTE1: begin
                if (third_bit == 1)
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                if (third_bit == 1)
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            default: next_state = BYTE1;
        end
    end

    // Output logic
    assign done = (state == DONE);

endmodule
