module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    assign out1 = (state[8] && !state[6]) ? 1'b1 :
                  (state[9] && state[7]) ? 1'b1 :
                  1'b0;
    
    assign out2 = (state[9] && state[7]) ? 1'b1 :
                  1'b0;

    always @* begin
        case (state)
            10'b00_000_0001: next_state = 10'b10_000_0000;
            10'b00_000_0010: next_state = 10'b01_000_0000;
            10'b01_000_0000: next_state = 10'b00_000_0001;
            10'b01_000_0010: next_state = 10'b00_000_0010;
            10'b00_000_0011: next_state = 10'b00_000_0001;
            10'b00_000_0100: next_state = 10'b00_000_0101;
            10'b00_000_0101: next_state = 10'b00_100_0000;
            10'b00_000_0110: next_state = 10'b00_100_0001;
            10'b00_000_1001: next_state = 10'b00_000_0001;
            10'b00_000_1010: next_state = 10'b01_000_0000;
            10'b01_000_0110: next_state = 10'b00_100_0001;
            10'b01_000_0111: next_state = 10'b01_000_0111;
            10'b00_001_0100: next_state = 10'b00_000_0001;
            10'b00_001_0101: next_state = 10'b00_000_0010;
            default: next_state = 10'b0;
        endcase
    end

endmodule
