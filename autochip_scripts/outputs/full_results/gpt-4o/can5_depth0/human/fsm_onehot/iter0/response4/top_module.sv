module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    // State transition logic
    always @(*) begin
        case (state)
            10'b0000000001: next_state = in ? 10'b0000000010 : 10'b0000000001; // S0
            10'b0000000010: next_state = in ? 10'b0000000100 : 10'b0000000001; // S1
            10'b0000000100: next_state = in ? 10'b0000001000 : 10'b0000000001; // S2
            10'b0000001000: next_state = in ? 10'b0000010000 : 10'b0000000001; // S3
            10'b0000010000: next_state = in ? 10'b0000100000 : 10'b0000000001; // S4
            10'b0000100000: next_state = in ? 10'b0001000000 : 10'b1000000000; // S5
            10'b0001000000: next_state = in ? 10'b0010000000 : 10'b0100000000; // S6
            10'b0010000000: next_state = in ? 10'b0010000000 : 10'b0000000001; // S7
            10'b0100000000: next_state = in ? 10'b0000000010 : 10'b0000000001; // S8
            10'b1000000000: next_state = in ? 10'b0000000010 : 10'b0000000001; // S9
            default: next_state = 10'b0000000001; // Default to S0 in case of invalid state
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            10'b0010000000: begin // S7
                out1 = 1'b0;
                out2 = 1'b1;
            end
            10'b0100000000: begin // S8
                out1 = 1'b1;
                out2 = 1'b0;
            end
            10'b1000000000: begin // S9
                out1 = 1'b1;
                out2 = 1'b1;
            end
            default: begin 
                out1 = 1'b0;
                out2 = 1'b0;
            end
        endcase
    end

endmodule
