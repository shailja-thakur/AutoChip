module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state, // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
 );

    reg B3_next;
    reg S_next;
    reg S1_next;
    reg Count_next;
    reg Wait_next;

    always @* begin
        case (state)
            // S Next State Logic
            S: begin
                if (d == 0) begin
                    S_next = 1;
                end else begin
                    S_next = 0;
                end
            end

            // S1 Next State Logic
            S1: begin
                if (d == 1) begin
                    S1_next = 1;
                end else begin
                    S1_next = 0;
                end
            end

            // B3 Next State Logic
            B2: begin
                B3_next = 1;
            end

            // Count Next State Logic
            B3: begin
                Count_next = 1;
            end

            Count: begin
                if (done_counting == 0) begin
                    Count_next = 1;
                end else begin
                    Count_next = 0;
                end
            end

            // Wait Next State Logic
            Wait: begin
                if (done_counting == 1) begin
                    Wait_next = 1;
                end else begin
                    Wait_next = 0;
                end
            end

            // Default
            default: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
        endcase
    end

    // Output Assignment
    assign done = (state == Wait) ? 1'b1 : 1'b0;
    assign counting = (state == Count) ? 1'b1 : 1'b0;
    assign shift_ena = (state == B3 || state == B2 || state == B1 || state == B0) ? 1'b1 : 1'b0;

endmodule
