module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    // State encoding using one-hot
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
        next_state = S0;
        out1 = 0;
        out2 = 0;

        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: next_state = in ? S6 : S8;
            S6: next_state = in ? S7 : S9;
            S7: begin
                next_state = in ? S7 : S0;
                out2 = 1;
            end
            S8: begin
                next_state = in ? S1 : S0;
                out1 = 1;
            end
            S9: begin
                next_state = in ? S1 : S0;
                out1 = 1;
                out2 = 1;
            end
            default: next_state = S0;
        endcase
    end 
endmodule
