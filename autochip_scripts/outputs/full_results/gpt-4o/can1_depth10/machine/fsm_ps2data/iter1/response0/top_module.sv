module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    localparam BYTE1 = 2'b00,
               BYTE2 = 2'b01,
               BYTE3 = 2'b10,
               DONE  = 2'b11;

    // State registers
    reg [1:0] current_state, next_state;

    // Intermediate register for shifting in bytes
    reg [23:0] shift_reg;

    // State machine: next state logic
    always @(*) begin
        case (current_state)
            BYTE1: next_state = (in[2]) ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = (in[2]) ? DONE : BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // State machine: state transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
            shift_reg <= 24'd0;
            out_bytes <= 24'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                BYTE1: shift_reg <= {shift_reg[15:0], in}; // shift in new byte
                BYTE2: shift_reg <= {shift_reg[15:0], in};
                BYTE3: shift_reg <= {shift_reg[15:0], in};
                DONE: begin
                    done <= 1'b1;
                    out_bytes <= shift_reg;
                end
            endcase

            // Reset done signal when moving out of DONE state
            if (current_state != DONE) begin
                done <= 1'b0;
            end
        end
    end

endmodule
