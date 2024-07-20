module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
);

reg done;
reg counting;
reg shift_ena;

always @(*) begin
    case(state)
        S: begin
            if (d == 0)
                S_next = 1;
        end
        
        S1: begin
            if (d == 0)
                S1_next = 1;
        end
        
        S110: begin
            if (d == 0)
                S_next = 1;
        end
        
        Wait: begin
            if (ack == 1)
                Wait_next = 1;
        end
        
        default: begin
            S_next = 0;
            S1_next = 0;
        end
    endcase
end

always @(state) begin
    case(state)
        B2: begin
            B3_next = 1;
        end
        
        default: begin
            B3_next = 0;
        end
    endcase
end

always @(state, done_counting) begin
    case(state)
        B3: begin
            Count_next = 1;
        end
        
        Count: begin
            if (done_counting == 0)
                Count_next = 1;
        end
        
        default: begin
            Count_next = 0;
        end
    endcase
end

always @(state, ack, done_counting) begin
    case(state)
        Count: begin
            if (done_counting == 1)
                Wait_next = 1;
        end
        
        B0, B1, B2, B3: begin
            shift_ena = 1;
        end
        
        default: begin
            shift_ena = 0;
        end
    endcase
end

always @(state, ack) begin
    case(state)
        Wait: begin
            if (ack == 0)
                Wait_next = 1;
        end
        
        default: begin
            Wait_next = 0;
        end
    endcase
end

assign done = (state == Wait);
assign counting = (state == Count);

endmodule
