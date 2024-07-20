module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    // State encoding
    parameter [2:0] S0 = 3'b000,
                    S1 = 3'b001,
                    S2 = 3'b010,
                    S3 = 3'b011,
                    S4 = 3'b100;
    
    // State register
    reg [2:0] state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case(state)
            S0: next_state = (x == 1'b1) ? S1 : S0;
            S1: next_state = (x == 1'b1) ? S4 : S1;
            S2: next_state = (x == 1'b1) ? S1 : S2;
            S3: next_state = (x == 1'b1) ? S2 : S1;
            S4: next_state = (x == 1'b1) ? S4 : S3;
            default: next_state = S0;
        endcase
    end

    // Output logic (combinational)
    always @(*) begin
        case(state)
            S3, S4: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
    
    // State register update (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end
endmodule
