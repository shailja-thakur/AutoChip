module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state, next_state; // State variables, 3 bits to count up to 4 cycles

    // State encoding
    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;

    // State transition logic (sequential)
    always @(posedge clk) begin
        if (reset) 
            state <= S0; 
        else 
            state <= next_state;
    end

    // Next state logic (combinational)
    always @(*) begin
        case (state)
            S0: next_state = (reset) ? S1 : S0;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S4;
            default: next_state = S0;
        endcase
    end

    // Output logic (combinational)
    always @(*) begin
        case (state)
            S0: shift_ena = 1'b0;
            S1: shift_ena = 1'b1;
            S2: shift_ena = 1'b1;
            S3: shift_ena = 1'b1;
            S4: shift_ena = 1'b1;
            default: shift_ena = 1'b0;
        endcase
    end

endmodule
