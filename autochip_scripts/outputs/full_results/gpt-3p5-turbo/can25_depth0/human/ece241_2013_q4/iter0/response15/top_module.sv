module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [3:0] state;  // state variable to track the water level state
reg [3:0] prev_state;  // previous state variable to track previous water level state

// Define the water level states
parameter ABOVE_S3 = 4'b1111;
parameter BETWEEN_S3_S2 = 4'b0111;
parameter BETWEEN_S2_S1 = 4'b0011;
parameter BELOW_S1 = 4'b0000;

// Define the nominal flow rates for different water levels
parameter NOMINAL_FR1 = 1'b1;
parameter NOMINAL_FR2 = 1'b1;
parameter NOMINAL_FR3 = 1'b1;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BELOW_S1;  // Reset state machine to lowest water level state
        fr3 <= NOMINAL_FR3;  // Set initial flow rate to nominal flow rate
        fr2 <= NOMINAL_FR2;
        fr1 <= NOMINAL_FR1;
        dfr <= 1'b0;  // Close the supplemental flow valve
        prev_state <= BELOW_S1; // Initialize previous state variable
    end else begin
        // Next state logic
        case (state)
            ABOVE_S3: begin
                if (s[1] && s[2] && s[3])
                    state <= ABOVE_S3;  // Stay in the current state if all sensors are asserted
                else
                    state <= BETWEEN_S3_S2;  // Transition to the next state if any sensor is de-asserted
            end
            BETWEEN_S3_S2: begin
                if (s[1] && s[2])
                    state <= BETWEEN_S3_S2;  // Stay in the current state if both sensors are asserted
                else if (s[1])
                    state <= BETWEEN_S2_S1;  // Transition to the next state if sensor 2 is de-asserted
                else
                    state <= BELOW_S1;  // Transition to the lowest state if all sensors are de-asserted
            end
            BETWEEN_S2_S1: begin
                if (s[1])
                    state <= BETWEEN_S2_S1;  // Stay in the current state if sensor 1 is asserted
                else
                    state <= BELOW_S1;  // Transition to the lowest state if sensor 1 is de-asserted
            end
            BELOW_S1: begin
                state <= BELOW_S1;  // Stay in the current state if no sensors are asserted
            end
        endcase

        // Output logic based on the current state
        case (state)
            ABOVE_S3: begin
                fr3 <= 1'b0;  // No flow allowed above sensor 3
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;  // Close the supplemental flow valve
            end
            BETWEEN_S3_S2: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= NOMINAL_FR1;
                dfr <= 1'b0;  // Close the supplemental flow valve
            end
            BETWEEN_S2_S1: begin
                fr3 <= 1'b0;
                fr2 <= NOMINAL_FR2;
                fr1 <= NOMINAL_FR1;
                dfr <= 1'b0;  // Close the supplemental flow valve
            end
            BELOW_S1: begin
                fr3 <= NOMINAL_FR3;
                fr2 <= NOMINAL_FR2;
                fr1 <= NOMINAL_FR1;
                dfr <= 1'b1;  // Open the supplemental flow valve
            end
            default: begin
                // Default case: should not occur
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
        endcase

        // Track previous state
        prev_state <= state;
    end
end

endmodule
