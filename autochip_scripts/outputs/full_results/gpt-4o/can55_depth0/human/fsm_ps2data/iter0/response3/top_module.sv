module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] byte_shift;

    // FSM state transition
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // FSM next state logic
    always @(*) begin
        case (state)
            IDLE: 
                if (in[3] == 1'b1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            BYTE1: 
                next_state = BYTE2;
            BYTE2: 
                next_state = BYTE3;
            BYTE3: 
                next_state = IDLE;
            default: 
                next_state = IDLE;
        endcase
    end

    // FSM output logic and data shift register
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            byte_shift <= 24'b0;
            done <= 1'b0;
        end else begin
            case(state)
                IDLE: begin
                    if (in[3] == 1'b1)
                        byte_shift <= { in, 16'b0 };
                    done <= 1'b0;
                end
                BYTE1: 
                    byte_shift <= { byte_shift[23:16], in, 8'b0 };
                BYTE2: 
                    byte_shift <= { byte_shift[23:8], in };
                BYTE3: begin
                    done <= 1'b1;
                    out_bytes <= byte_shift | in;
                end
                default: begin
                    done <= 1'b0;
                    out_bytes <= 24'b0;
                end
            endcase
            if (state != BYTE3)
                done <= 1'b0;
        end
    end

endmodule
