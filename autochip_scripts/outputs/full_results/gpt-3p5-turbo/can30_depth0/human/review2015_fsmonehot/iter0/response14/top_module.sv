module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
);

// State transition logic
always @(state or d) begin
    case(state)
        10'b0000000001: begin
            if (d == 1)
                S_next = 1;
            else
                S_next = 1;
        end
        
        10'b0000000010: begin
            if (d == 1)
                S1_next = 1;
            else
                S1_next = 1;
        end
        
        10'b0000000100: begin
            if (d == 1)
                S1_next = 1;
            else
                S1_next = 10'b0000000001;
        end
        
        10'b0000001000: begin
            if (d == 1)
                S1_next = 10'b0000000001;
            else
                S1_next = 10'b1000000000;
        end
        
        10'b0000010000: begin
            if (d == 1)
                B3_next = 10'b1000000000;
            else
                B3_next = 10'b1000000000;
        end
    endcase
end

// Output logic
always @(state or d) begin
    case(state)
        10'b0000000001: begin
            counting = 0;
            shift_ena = 0;
            done = 0;
        end
        
        10'b0000000010: begin
            counting = 0;
            shift_ena = 0;
            done = 0;
        end
        
        10'b0000000100: begin
            counting = 0;
            shift_ena = 0;
            done = 0;
        end
        
        10'b0000001000: begin
            counting = 0;
            shift_ena = 1;
            done = 0;
        end
        
        10'b0000010000: begin
            counting = 0;
            shift_ena = 1;
            done = 0;
        end
        
        10'b1000000000: begin
            counting = 1;
            shift_ena = 1;
            done = 0;
        end
    endcase
end

// Next State assignments
always @(posedge clk or negedge reset) begin
    if (!reset) begin
        S_next <= 1'b0;
        S1_next <= 1'b0;
        Count_next <= 1'b0;
        Wait_next <= 1'b0;
        B3_next <= 1'b0;
        done <= 1'b0;
        counting <= 1'b0;
        shift_ena <= 1'b0;
    end else begin
        S_next <= S_next;
        S1_next <= S1_next;
        Count_next <= Count_next;
        Wait_next <= Wait_next;
        B3_next <= B3_next;
        done <= done;
        counting <= counting;
        shift_ena <= shift_ena;
    end
end

endmodule
