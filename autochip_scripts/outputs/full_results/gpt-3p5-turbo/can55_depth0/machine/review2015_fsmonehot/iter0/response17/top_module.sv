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

    // Define all the states
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

    // Assign default values to outputs
    assign B3_next = 1'b0;
    assign S_next = 1'b0;
    assign S1_next = 1'b0;
    assign Count_next = 1'b0;
    assign Wait_next = 1'b0;
    assign done = 1'b0;
    assign counting = 1'b0;
    assign shift_ena = 1'b0;

    // Check state and d conditions for B3_next
    always @*
    begin
        if (state == B2 && d == 1'b1)
            B3_next = 1'b1;
    end

    // Check state and d conditions for S_next
    always @*
    begin
        if ((state == S && d == 1'b0) ||
            (state == S1 && d == 1'b0) ||
            (state == S110 && d == 1'b0) ||
            (state == Wait && ack == 1'b1))
            S_next = 1'b1;
    end

    // Check state and d conditions for S1_next
    always @*
    begin
        if (state == S && d == 1'b1)
            S1_next = 1'b1;
    end

    // Check state and done_counting conditions for Count_next
    always @*
    begin
        if (state == B3 || (state == Count && done_counting == 1'b0))
            Count_next = 1'b1;
    end

    // Check state and done_counting conditions for Wait_next
    always @*
    begin
        if (state == Count && done_counting == 1'b1 ||
            (state == Wait && ack == 1'b0))
            Wait_next = 1'b1;
    end

    // Set done signal in Wait state
    always @*
    begin
        if (state == Wait)
            done = 1'b1;
    end

    // Set counting signal in Count state
    always @*
    begin
        if (state == Count)
            counting = 1'b1;
    end

    // Set shift_ena signal if any of the B states are active
    always @*
    begin
        if (state == B0 || state == B1 || state == B2 || state == B3)
            shift_ena = 1'b1;
    end

endmodule
