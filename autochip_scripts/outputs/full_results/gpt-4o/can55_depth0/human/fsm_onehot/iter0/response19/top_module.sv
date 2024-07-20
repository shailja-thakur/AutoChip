module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    // Define state encoding
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

    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: next_state = in ? S6 : S8;
            S6: next_state = in ? S7 : S9;
            S7: next_state = in ? S7 : S0;
            S8: next_state = in ? S1 : S0;
            S9: next_state = in ? S1 : S0;
            default: next_state = S0;  // Default state for safety
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            S0, S1, S2, S3, S4, S5, S6: begin
                out1 = 0;
                out2 = 0;
            end
            S7: begin
                out1 = 0;
                out2 = 1;
            end
            S8: begin
                out1 = 1;
                out2 = 0;
            end
            S9: begin
                out1 = 1;
                out2 = 1;
            end
            default: begin
                out1 = 0;
                out2 = 0;
            end
        endcase
    end

endmodule
