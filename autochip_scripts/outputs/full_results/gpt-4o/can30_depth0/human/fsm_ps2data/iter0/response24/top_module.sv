module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] message;
    
    // State encoding
    localparam WAIT_FIRST = 2'b00, BYTE1 = 2'b01, BYTE2 = 2'b10, DONE = 2'b11;

    // State transitions
    always @(posedge clk) begin
        if (reset)
            state <= WAIT_FIRST;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            WAIT_FIRST: begin
                if (in[3] == 1)
                    next_state = BYTE1;
                else
                    next_state = WAIT_FIRST;
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = DONE;
            DONE: next_state = WAIT_FIRST;
            default: next_state = WAIT_FIRST;
        endcase
    end
    
    // Output logic and message decoding
    always @(posedge clk) begin
        if (reset) begin
            message <= 24'bx;
            out_bytes <= 24'bx;
            done <= 0;
        end
        else begin
            case (state)
                WAIT_FIRST: begin
                    message <= 24'bx;
                    out_bytes <= 24'bx;
                    done <= 0;
                end
                BYTE1: begin
                    message[23:16] <= in;
                    out_bytes <= 24'bx;
                    done <= 0;
                end
                BYTE2: begin
                    message[15:8] <= in;
                    out_bytes <= 24'bx;
                    done <= 0;
                end
                DONE: begin
                    message[7:0] <= in;
                    out_bytes <= message;
                    done <= 1;
                end
                default: begin
                    out_bytes <= 24'bx;
                    done <= 0;
                end
            endcase
        end
    end
    
endmodule
