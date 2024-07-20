module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output wire B3_next,
    output wire S_next,
    output wire S1_next,
    output wire Count_next,
    output wire Wait_next,
    output wire done,
    output wire counting,
    output wire shift_ena
);

    // Define the states as parameters
    parameter [9:0] S = 10'b0000000001;    // S state
    parameter [9:0] S1 = 10'b0000000010;   // S1 state
    parameter [9:0] S11 = 10'b0000000011;  // S11 state
    parameter [9:0] S110 = 10'b0000000100; // S110 state
    parameter [9:0] B0 = 10'b0000001000;   // B0 state
    parameter [9:0] B1 = 10'b0000010000;   // B1 state
    parameter [9:0] B2 = 10'b0000100000;   // B2 state
    parameter [9:0] B3 = 10'b0001000000;   // B3 state
    parameter [9:0] Count = 10'b0010000000;   // Count state
    parameter [9:0] Wait = 10'b0100000000;    // Wait state

    // Assign default values to the output signals
    always @* begin
        // Initialize output signals
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
        done = 1'b0;
        counting = 1'b0;
        shift_ena = 1'b0;
        
        case (state)
            S: begin
                if (d == 0 && (state != S110) && (state != Wait)) begin
                    S_next = 1'b1;
                end
                else begin
                    done = 1'b1;
                    if (ack == 1'b1) begin
                        Wait_next = 1'b1;
                    end
                end
            end
            S1: begin
                if (d == 1'b1 && state == S) begin
                    S1_next = 1'b1;
                end
                else begin
                    B3_next = 1'b1;
                end
            end
            S11: begin
                B3_next = 1'b1;
            end
            S110: begin
                B3_next = 1'b1;
            end
            B0: begin
                shift_ena = 1'b1;
                if (state == B2) begin
                    B3_next = 1'b1;
                end
            end
            B1: begin
                shift_ena = 1'b1;
                if (state == B2) begin
                    B3_next = 1'b1;
                end
            end
            B2: begin
                shift_ena = 1'b1;
            end
            B3: begin
                shift_ena = 1'b1;
            end
            Count: begin
                counting = 1'b1;
                shift_ena = 1'b1;
                if (state == B3) begin
                    B3_next = 1'b1;
                end
                if (done_counting == 1'b0) begin
                    Count_next = 1'b1;
                end
            end
            Wait: begin
                done = 1'b1;
                shift_ena = 1'b1;
                if (state == B3) begin
                    B3_next = 1'b1;
                end
                if (ack == 1'b0) begin
                    Wait_next = 1'b1;
                end
            end
        endcase
    end

endmodule
