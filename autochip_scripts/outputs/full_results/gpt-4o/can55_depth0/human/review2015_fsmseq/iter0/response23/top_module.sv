module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [2:0] state, next_state;
    
    // State encoding
    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;
    
    // State transition on clock edge
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            start_shifting <= 0;
        end else begin
            state <= next_state;
            if (next_state == S4)
                start_shifting <= 1;
        end
    end
    
    // Determine next state based on current state and input data
    always @(*) begin
        case (state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = S4;  // Remains in state S4
            default: next_state = S0;
        endcase
    end

endmodule
