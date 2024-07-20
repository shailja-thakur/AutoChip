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

    // State declarations
    localparam S = 10'b0000000001;   // State S
    localparam S1 = 10'b0000000010;  // State S1
    localparam S11 = 10'b0000110100; // State S11
    localparam S110 = 10'b0000111000; // State S110
    localparam B0 = 10'b0000111100;  // State B0
    localparam B1 = 10'b0000111110;  // State B1
    localparam B2 = 10'b0000111111;  // State B2
    localparam B3 = 10'b0000011111;  // State B3
    localparam Count = 10'b0000010000;  // State Count
    localparam Wait = 10'b0000110101;  // State Wait

    // State transitions
    always @(state) begin
        case(state)
            S: begin
                if (d == 0) begin
                    S_next = 1;
                    S1_next = 1;
                end
                else begin
                    S_next = 0;
                    S1_next = 0;
                end
                
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end

            S1: begin
                if (d == 1) begin
                    S_next = 0;
                    S1_next = 1;
                end
                else begin
                    S_next = 1;
                    S1_next = 0;
                end
                
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end

            S11: begin
                // State S11 logic
            end

            S110: begin
                // State S110 logic
            end

            B0: begin
                // State B0 logic
            end

            B1: begin
                // State B1 logic
            end

            B2: begin
                if (state == B2) begin
                    B3_next = 1;
                end
                else begin
                    B3_next = 0;
                end
                
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end

            B3: begin
                if (state == B3) begin
                    B3_next = 0;
                end
                else begin
                    B3_next = 0;
                end
                
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end

            Count: begin
                if (state == Count) begin
                    Count_next = 0;
                end
                else begin
                    Count_next = 0;
                end
                
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Wait_next = 0;
            end

            Wait: begin
                if (ack == 1) begin
                    Wait_next = 1;
                end
                else begin
                    Wait_next = 0;
                end
                
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
            end
            
            default: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
        endcase
    end

    // Output assignments
    assign shift_ena = (state == B3 || state == B2 || state == B1 || state == B0) ? 1 : 0;
    assign done = (state == Wait) ? 1 : 0;
    assign counting = (state == Count) ? 1 : 0;

endmodule
