module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

// Define the states of the state machine
parameter ABOVE_S3 = 2'b00, BETWEEN_S3_S2 = 2'b01, BETWEEN_S2_S1 = 2'b10, BELOW_S1 = 2'b11;

// Current state and next state variables
reg [1:0] current_state, next_state;

// Combinational logic for next state
always @(*) begin
    case (current_state)
        ABOVE_S3: begin
            if (s[3]) next_state = ABOVE_S3;
            else if (s[2]) next_state = BETWEEN_S3_S2;
            else next_state = BETWEEN_S2_S1;
        end
        BETWEEN_S3_S2: begin
            if (s[3]) next_state = ABOVE_S3;
            else if (s[2]) next_state = BETWEEN_S3_S2;
            else next_state = BETWEEN_S2_S1;
        end
        BETWEEN_S2_S1: begin
            if (s[2]) next_state = BETWEEN_S3_S2;
            else if (s[1]) next_state = BETWEEN_S2_S1;
            else next_state = BELOW_S1;
        end
        BELOW_S1: begin
            if (s[1]) next_state = BETWEEN_S2_S1;
            else next_state = BELOW_S1;
        end
        default: next_state = BELOW_S1;
    endcase
end

// Sequential logic for state update
always @(posedge clk or posedge reset) begin
    if (reset) current_state <= BELOW_S1;
    else current_state <= next_state;
end

// Combinational logic for output
always @(*) begin
    case (current_state)
        ABOVE_S3: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b0;
            dfr = 1'b0;
        end
        BETWEEN_S3_S2: begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b0;
            dfr = 1'b0;
        end
        BETWEEN_S2_S1: begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b0;
        end
        BELOW_S1: begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b1;
        end
        default: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b0;
            dfr = 1'b0;
        end
    endcase
end

endmodule
