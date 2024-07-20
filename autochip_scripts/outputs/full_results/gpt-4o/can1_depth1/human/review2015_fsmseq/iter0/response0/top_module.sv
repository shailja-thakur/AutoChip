module top_module (
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    reg [2:0] state, next_state;
    
    // State encoding
    parameter IDLE = 3'b000;
    parameter S1 = 3'b001;
    parameter S11 = 3'b010;
    parameter S110 = 3'b011;
    parameter S1101 = 3'b100;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            IDLE: next_state = data ? S1 : IDLE;
            S1: next_state = data ? S11 : IDLE;
            S11: next_state = data ? S11 : S110;
            S110: next_state = data ? S1101 : IDLE;
            S1101: next_state = S1101;  // Stay in this state once the sequence is detected
            default: next_state = IDLE;
        endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 0;
        end else if (state == S1101) begin
            start_shifting <= 1;
        end
    end
    
endmodule
