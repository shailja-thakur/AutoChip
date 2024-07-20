module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

    // State encoding
    localparam S0 = 10'b0000000001;
    localparam S1 = 10'b0000000010;
    localparam S2 = 10'b0000000100;
    localparam S3 = 10'b0000001000;
    localparam S4 = 10'b0000010000;
    localparam S5 = 10'b0000100000;
    localparam S6 = 10'b0001000000;
    localparam S7 = 10'b0010000000;
    localparam S8 = 10'b0100000000;
    localparam S9 = 10'b1000000000;

    always @(*) begin
        // Default values
        next_state = 10'b0000000000;
        out1 = 0;
        out2 = 0;

        case (1'b1) // one-hot encoding: only one bit of state is '1'
            state[0]: next_state = in ? S1 : S0;
            state[1]: next_state = in ? S2 : S0;
            state[2]: next_state = in ? S3 : S0;
            state[3]: next_state = in ? S4 : S0;
            state[4]: next_state = in ? S5 : S0;
            state[5]: next_state = in ? S6 : S8;
            state[6]: next_state = in ? S7 : S9;
            state[7]: next_state = in ? S7 : S0;
            state[8]: next_state = in ? S1 : S0;
            state[9]: next_state = in ? S1 : S0;
        endcase

        // Output logic
        case (1'b1)
            state[7]: out2 = 1;
            state[8]: out1 = 1;
            state[9]: begin
                out1 = 1;
                out2 = 1;
            end
        endcase
    end
endmodule
