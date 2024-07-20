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

    // Define the states
    parameter S = 10'b0000000001;
    parameter S1 = 10'b0000000010;
    parameter S11 = 10'b0000000100;
    parameter S110 = 10'b0000001000;
    parameter B0 = 10'b0000010000;
    parameter B1 = 10'b0000100000;
    parameter B2 = 10'b0001000000;
    parameter B3 = 10'b0010000000;
    parameter Count = 10'b0100000000;
    parameter Wait = 10'b1000000000;
    
    reg [9:0] next_state;
    
    always @* begin
        next_state = state;
        
        case (state)
            S: begin
                if (d == 0) begin
                    next_state = S_next;
                end else begin
                    next_state = S1_next;
                end
            end
            
            S1: begin
                if (d == 0) begin
                    next_state = S_next;
                end else begin
                    next_state = S1_next;
                end
            end
            
            S11: begin
                if (d == 0) begin
                    next_state = S_next;
                end else begin
                    next_state = S1_next;
                end
            end
            
            S110: begin
                if (d == 0) begin
                    next_state = S_next;
                end else begin
                    next_state = S1_next;
                end
            end
            
            B0: begin
                next_state = B3_next;
            end
            
            B1: begin
                next_state = B3_next;
            end
            
            B2: begin
                next_state = B3_next;
            end
            
            B3: begin
                next_state = B3_next;
            end
            
            Count: begin
                if (done_counting == 0) begin
                    next_state = Count_next;
                end else begin
                    next_state = Wait_next;
                end
            end
            
            Wait: begin
                if (ack == 0) begin
                    next_state = Wait_next;
                end else begin
                    next_state = Wait_next;
                end
            end
        endcase
    end
    
    assign B3_next = (state == B2) ? 1'b1 : 1'b0;
    assign S_next = ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1)) ? 1'b1 : 1'b0;
    assign S1_next = (state == S && d == 1) ? 1'b1 : 1'b0;
    assign Count_next = (state == B3 || (state == Count && done_counting == 0)) ? 1'b1 : 1'b0;
    assign Wait_next = (state == Count && done_counting == 1) ? 1'b1 : (state == Wait && ack == 0) ? 1'b1 : 1'b0;
    
    assign done = (state == Wait) ? 1'b1 : 1'b0;
    assign counting = (state == Count) ? 1'b1 : 1'b0;
    assign shift_ena = (state == B3 || state == B2 || state == B1 || state == B0) ? 1'b1 : 1'b0;
        
endmodule
