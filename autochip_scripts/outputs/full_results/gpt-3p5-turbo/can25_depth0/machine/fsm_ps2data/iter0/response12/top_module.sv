module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

    reg [23:0] register = 0;
    reg [1:0] state = 0;
    reg next_state = 0;

    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            register <= 0;
            state <= 0;
        end
        else
        begin
            case(state)
                0: // BYTE1 state
                    if (in[2] == 1'b1)
                        next_state = 1; // BYTE2
                    else
                        next_state = 0; // BYTE1
                1: // BYTE2 state
                    if (in[2] == 1'b1)
                        next_state = 2; // BYTE3
                    else
                        next_state = 0; // BYTE1
                2: // BYTE3 state
                    if (in[2] == 1'b1)
                        next_state = 3; // DONE
                    else
                        next_state = 0; // BYTE1
                3: // DONE state
                    if (in[2] == 1'b0)
                        next_state = 0; // BYTE1
                    else
                        next_state = 3; // DONE
                default:
                    next_state = 0;
            endcase

            if (next_state == 3)
                done <= 1'b1;
            else
                done <= 1'b0;

            if (done)
                out_bytes <= register;

            register <= {register[15:0], in};
            state <= next_state;
        end
    end
    
endmodule
