module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    // Define the states using local parameters
    localparam B0 = 3'd0,
               B1 = 3'd1,
               B2 = 3'd2,
               B3 = 3'd3,
               DONE = 3'd4;

    // State register to hold the current state
    reg [2:0] state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = DONE;
            DONE: next_state = DONE;
            default: next_state = DONE; // Default to DONE if an unknown state is encountered
        endcase
    end

    // State register logic (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B0; // Reset to B0 on reset signal
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (state == B0 || state == B1 || state == B2 || state == B3)
            shift_ena = 1;
        else
            shift_ena = 0;
    end

endmodule
