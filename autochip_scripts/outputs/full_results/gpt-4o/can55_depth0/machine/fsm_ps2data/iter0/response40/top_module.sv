module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Declaration of state encoding
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg [23:0] shift_reg;

    // State transition logic
    always @(*) begin
        case (current_state)
            BYTE1: next_state = (in[2] == 1'b1) ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // Sequential block for state transitions and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
            shift_reg <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end
        else begin
            current_state <= next_state;
            case (current_state)
                BYTE1: shift_reg <= {shift_reg[15:0], in};
                BYTE2: shift_reg <= {shift_reg[15:0], in};
                BYTE3: shift_reg <= {shift_reg[15:0], in};
                DONE: begin
                    shift_reg <= shift_reg; // Maintain shift register value
                    out_bytes <= shift_reg;
                    done <= 1'b1;
                end
            endcase

            if (current_state != DONE) begin
                done <= 1'b0;
            end
        end
    end

endmodule
