module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [2:0] state, next_state;

// State encoding
localparam S0 = 3'b000,
           S1 = 3'b001,
           S2 = 3'b010,
           S3 = 3'b011,
           S4 = 3'b100;

// State transition
always @(posedge clk) begin
    if (reset) 
        state <= S0;
    else 
        state <= next_state;
end

// Next state logic and output logic
always @(*) begin
    case (state)
        S0: begin
            shift_ena = 1;
            next_state = S1;
        end
        S1: begin
            shift_ena = 1;
            next_state = S2;
        end
        S2: begin
            shift_ena = 1;
            next_state = S3;
        end
        S3: begin
            shift_ena = 1;
            next_state = S4;
        end
        S4: begin
            shift_ena = 0;
            next_state = S4;
        end
        default: begin
            shift_ena = 0;
            next_state = S0;
        end
    endcase
end

endmodule
