module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // Define state encoding
    localparam IDLE   = 3'b000;
    localparam S1     = 3'b001;
    localparam S11    = 3'b010;
    localparam S110   = 3'b011;
    localparam S1101  = 3'b100;
    
    reg [2:0] state, next_state;
    
    // State transition logic
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            IDLE:   next_state = data ? S1 : IDLE;
            S1:     next_state = data ? S11 : IDLE;
            S11:    next_state = data ? S11 : S110;
            S110:   next_state = data ? S1101 : IDLE;
            S1101:  next_state = S1101; // Remain in this state once sequence is found
            default: next_state = IDLE;
        endcase
    end
    
    // Output logic
    always @(posedge clk) begin
        if (reset)
            start_shifting <= 1'b0;
        else if (state == S1101)
            start_shifting <= 1'b1;
    end
    
endmodule
