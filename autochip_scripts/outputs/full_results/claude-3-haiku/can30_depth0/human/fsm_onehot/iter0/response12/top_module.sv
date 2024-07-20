module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

always @(*) begin
    case (state)
        10'b0000000001: begin // S0
            next_state = (in) ? 10'b0000000010 : 10'b0000000001;
            out1 = 1'b0;
            out2 = 1'b0;
        end
        10'b0000000010: begin // S1
            next_state = (in) ? 10'b0000000100 : 10'b0000000001;
            out1 = 1'b0;
            out2 = 1'b0;
        end
        10'b0000000100: begin // S2
            next_state = (in) ? 10'b0000001000 : 10'b0000000001;
            out1 = 1'b0;
            out2 = 1'b0;
        end
        10'b0000001000: begin // S3
            next_state = (in) ? 10'b0000010000 : 10'b0000000001;
            out1 = 1'b0;
            out2 = 1'b0;
        end
        10'b0000010000: begin // S4
            next_state = (in) ? 10'b0000100000 : 10'b0000000001;
            out1 = 1'b0;
            out2 = 1'b0;
        end
        10'b0000100000: begin // S5
            next_state = (in) ? 10'b0001000000 : 10'b1000000000;
            out1 = 1'b0;
            out2 = 1'b0;
        end
        10'b0001000000: begin // S6
            next_state = (in) ? 10'b0010000000 : 10'b0100000000;
            out1 = 1'b0;
            out2 = 1'b0;
        end
        10'b0010000000: begin // S7
            next_state = (in) ? 10'b0010000000 : 10'b0000000001;
            out1 = 1'b0;
            out2 = 1'b1;
        end
        10'b0100000000: begin // S8
            next_state = (in) ? 10'b0000000010 : 10'b0000000001;
            out1 = 1'b1;
            out2 = 1'b0;
        end
        10'b1000000000: begin // S9
            next_state = (in) ? 10'b0000000010 : 10'b0000000001;
            out1 = 1'b1;
            out2 = 1'b1;
        end
        default: begin
            next_state = 10'b0000000001; // Default to state S0
            out1 = 1'b0;
            out2 = 1'b0;
        end
    endcase
end

endmodule
