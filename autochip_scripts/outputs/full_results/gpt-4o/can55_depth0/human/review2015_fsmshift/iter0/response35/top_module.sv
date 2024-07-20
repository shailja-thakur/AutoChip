module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] state;
    reg [2:0] next_state;
    
    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;

    // State transition
    always @(posedge clk) begin
        if (reset) 
            state <= S0;
        else 
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S4;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) 
            shift_ena <= 1;
        else if (state == S4)
            shift_ena <= 0;
        else
            shift_ena <= shift_ena;
    end
endmodule
