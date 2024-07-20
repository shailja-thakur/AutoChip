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

    // Define state encoding based on one-hot
    localparam S = 10'b0000000001;
    localparam S1 = 10'b0000000010;
    localparam S11 = 10'b0000000100;
    localparam S110 = 10'b0000001000;
    localparam B0 = 10'b0000010000;
    localparam B1 = 10'b0000100000;
    localparam B2 = 10'b0001000000;
    localparam B3 = 10'b0010000000;
    localparam Count = 10'b0100000000;
    localparam Wait = 10'b1000000000;

    always @(*) begin
        // Set defaults for outputs
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;
        done = 0;
        counting = 0;
        shift_ena = 0;
        
        case (state)
            S: begin
                if (d == 1'b0) S_next = 1;
                else S1_next = 1;
            end
            
            S1: if (d == 1'b0) S_next = 1;
            
            S11: if (d == 1'b0) S_next = 1;
            
            S110: if (d == 1'b0) S_next = 1;
            
            B0, B1, B2, B3: begin
                shift_ena = 1;
                
                if (state == B2) B3_next = 1;
                
                if (state == B3) Count_next = 1;
            end
            
            Count: if (done_counting == 0) Count_next = 1;
            else Wait_next = 1;
            
            Wait: begin
                if (ack == 1) S_next = 1;
                else Wait_next = 1;
                done = 1;
            end
        endcase
        
        if (state == Count) counting = 1;
        if (state == Wait) done = 1;
    end

endmodule
