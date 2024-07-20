module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    reg [9:0] next_state;
    reg out1;
    reg out2;

    always @(*) begin
        case (state)
            10'b0000000001: begin    // S0
                next_state = in ? 10'b0000000010 : 10'b0000000001;
                out1 = 0;
                out2 = 0;
            end
            10'b0000000010: begin    // S1
                next_state = in ? 10'b0000000100 : 10'b0000000001;
                out1 = 0;
                out2 = 0;
            end
            10'b0000000100: begin    // S2
                next_state = in ? 10'b0000001000 : 10'b0000000001;
                out1 = 0;
                out2 = 0;
            end
            10'b0000001000: begin    // S3
                next_state = in ? 10'b0000010000 : 10'b0000000001;
                out1 = 0;
                out2 = 0;
            end
            10'b0000010000: begin    // S4
                next_state = in ? 10'b0000100000 : 10'b0000000010;
                out1 = 0;
                out2 = 0;
            end
            10'b0000100000: begin    // S5
                next_state = in ? 10'b0000000001 : 10'b0000100000;
                out1 = 0;
                out2 = 0;
            end
            10'b0000000001: begin    // S6
                next_state = in ? 10'b0000000010 : 10'b0000010000;
                out1 = 0;
                out2 = 0;
            end
            10'b0000000010: begin    // S7
                next_state = in ? 10'b0000000010 : 10'b0000000100;
                out1 = 0;
                out2 = 0;
            end
            10'b0000000100: begin    // S8
                next_state = in ? 10'b0000000100 : 10'b0000000001;
                out1 = 1;
                out2 = 0;
            end
            10'b0000000001: begin    // S9
                next_state = in ? 10'b0000000100 : 10'b0000000001;
                out1 = 1;
                out2 = 1;
            end
            default: begin
                next_state = 10'bxxxxxxxxxx;
                out1 = 0;
                out2 = 0;
            end
        endcase
    end

endmodule
