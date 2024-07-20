module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // declare state registers
    reg [2:0] state, next_state;
    
    // State encoding
    localparam S0 = 3'd0,
               S1 = 3'd1,
               S2 = 3'd2,
               S3 = 3'd3,
               S4 = 3'd4,
               S5 = 3'd5,
               S6 = 3'd6,
               S7 = 3'd7;
               
    // State transition
    always @(*) begin
        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: next_state = in ? S6 : S0;
            S6: next_state = in ? S7 : S0;
            S7: next_state = in ? S7 : S0;
            default: next_state = S0;
        endcase
    end
    
    // State output logic and state update
    always @(posedge clk) begin
        if (reset) begin
            state <= S0; // Synchronous reset
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end 
        else begin
            state <= next_state;
            
            disc <= (state == S5 && !in);
            flag <= (state == S5 && in);
            err <= (state == S6 && in);
        end
    end

endmodule
