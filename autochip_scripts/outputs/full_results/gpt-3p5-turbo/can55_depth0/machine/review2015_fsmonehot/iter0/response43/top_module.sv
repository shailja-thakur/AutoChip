module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,     // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
);
    
    // Assign initial values to outputs
    initial begin
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;
        done = 0;
        counting = 0;
        shift_ena = 0;
    end
    
    // State S and d is 0, or S1 and d is 0, or S110 and d is 0, or Wait and ack is 1
    always @(*) begin
        case(state)
            // S and d is 0
            2'b00: S_next = (d == 0);
            // S1 and d is 0
            2'b01: S1_next = (d == 0);
            // S110 and d is 0
            3'b100: S_next = (d == 0);
            // Wait and ack is 1
            1'b1: Wait_next = (ack == 1);
            default: begin
                S_next = 0;
                S1_next = 0;
            end
        endcase
    end
    
    // State S and d is 1
    always @(*) begin
        if(state == 2'b00) begin
            S1_next = (d == 1);
        end
    end
    
    // State B3 is active, or Count and done_counting is 0
    always @(*) begin
        case(state)
            // B3 is active
            3'b011: B3_next = 1;
            // Count and done_counting is 0
            3'b111: Count_next = (done_counting == 0);
            default: begin
                B3_next = 0;
                Count_next = 0;
            end
        endcase
    end
    
    // State Count and done_counting is 1, or Wait and ack is 0
    always @(*) begin
        case(state)
            // Count and done_counting is 1
            3'b111: Wait_next = (done_counting == 1);
            // Wait and ack is 0
            1'b0: Count_next = (ack == 0);
            default: begin
                Count_next = 0;
                Wait_next = 0;
            end
        endcase
    end
    
    // Any of the states B3, B2, B1, and B0 is active
    always @(*) begin
        case(state)
            // B3, B2, B1, and B0 is active
            4'b0111: shift_ena = 1;
            default: shift_ena = 0;
        endcase
    end
    
    // State Wait
    always @(*) begin
        done = (state == 2'b10);
        counting = (state == 3'b111);
    end
    
endmodule
