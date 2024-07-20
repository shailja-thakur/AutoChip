module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    // Define state parameters for better readability
    parameter S0 = 10'b0000000001;
    parameter S1 = 10'b0000000010;
    parameter S2 = 10'b0000000100;
    parameter S3 = 10'b0000001000;
    parameter S4 = 10'b0000010000;
    parameter S5 = 10'b0000100000;
    parameter S6 = 10'b0001000000;
    parameter S7 = 10'b0010000000;
    parameter S8 = 10'b0100000000;
    parameter S9 = 10'b1000000000;

    // State transition logic
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
            default: next_state = S0; // safe default state
        endcase
    end

    // Output logic
    always @(*) begin
        out1 = 0;
        out2 = 0;
        case (state)
            S7: out2 = 1;
            S8: out1 = 1;
            S9: begin
                out1 = 1;
                out2 = 1;
            end
        endcase
    end
    
endmodule
