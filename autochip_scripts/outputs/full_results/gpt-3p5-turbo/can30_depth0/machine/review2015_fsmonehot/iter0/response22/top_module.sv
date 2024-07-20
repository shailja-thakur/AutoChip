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
 
 always @(state) begin
    case(state)
        S: begin
            if (d == 0)
                S_next = 1'b1;
            else
                S_next = 1'b0;
        end
        
        S1: begin
            if (d == 0)
                S1_next = 1'b1;
            else
                S1_next = 1'b0;
        end
        
        S110: begin
            if (d == 0)
                S_next = 1'b1;
            else
                S_next = 1'b0;
        end
        
        Wait: begin
            if (ack == 1)
                Wait_next = 1'b1;
            else
                Wait_next = 1'b0;
        end
        
        default: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            Wait_next = 1'b0;
        end
    endcase
end

always @(state) begin
    case(state)
        B3: begin
            B3_next = 1'b1;
        end
        
        default: begin
            B3_next = 1'b0;
        end
    endcase
end

always @(state) begin
    case(state)
        B3, B2, B1, B0: begin
            shift_ena = 1'b1;
        end
        
        default: begin
            shift_ena = 1'b0;
        end
    endcase
end

always @(state) begin
    case(state)
        Count: begin
            if (done_counting == 0 || B3 == 1)
                Count_next = 1'b1;
            else
                Count_next = 1'b0;
        end
        
        default: begin
            Count_next = 1'b0;
        end
    endcase
end

always @(state) begin
    case(state)
        Count: begin
            if (done_counting == 1)
                Wait_next = 1'b1;
            else
                Wait_next = 1'b0;
        end
        
        Wait: begin
            if (ack == 0)
                Wait_next = 1'b1;
            else
                Wait_next = 1'b0;
        end
        
        default: begin
            Wait_next = 1'b0;
        end
    endcase
end

assign counting = (state == Count) ? 1'b1 : 1'b0;
assign done = (state == Wait) ? 1'b1 : 1'b0;

endmodule
