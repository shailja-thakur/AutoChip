module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State Declarations
    typedef enum reg [1:0] {
        WAIT_HEADER = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [23:0] bytes;

    // State Transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= WAIT_HEADER;
        else
            state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case (state)
            WAIT_HEADER: begin
                if (in[3] == 1)
                    next_state = BYTE_1;
                else
                    next_state = WAIT_HEADER;
            end
            BYTE_1: next_state = BYTE_2;
            BYTE_2: next_state = BYTE_3;
            BYTE_3: next_state = WAIT_HEADER;
            default: next_state = WAIT_HEADER;
        endcase
    end

    // Output Logic and Byte Accumulation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bytes <= 24'b0;
            done <= 0;
            out_bytes <= 24'b0;
        end else begin
            done <= 0;
            case (state)
                WAIT_HEADER: begin
                    if (in[3] == 1)
                        bytes[23:16] <= in;
                end
                BYTE_1: bytes[15:8] <= in;
                BYTE_2: bytes[7:0] <= in;
                BYTE_3: begin
                    out_bytes <= bytes;
                    done <= 1;
                end
            endcase
        end
    end

endmodule
