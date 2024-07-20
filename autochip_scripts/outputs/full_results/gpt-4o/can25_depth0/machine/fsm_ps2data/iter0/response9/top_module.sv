module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    // State declaration
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [23:0] shift_reg;

    // State transition logic
    always @(*) begin
        case (state)
            BYTE1: next_state = (in[2] == 1'b1) ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = (in[2] == 1'b0) ? BYTE1 : DONE;
            default: next_state = BYTE1;
        endcase
    end

    // Sequential logic for state registers
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Output logic and shift register update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 24'd0;
            out_bytes <= 24'd0;
            done <= 1'b0;
        end else begin
            case (state)
                BYTE1: begin
                    if (in[2] == 1'b1) begin
                        shift_reg <= {shift_reg[15:0], in}; // Shift left by 8 bits and input new byte
                    end
                    done <= 1'b0;
                end
                BYTE2: begin
                    shift_reg <= {shift_reg[15:0], in}; // Shift left by 8 bits and input new byte
                    done <= 1'b0;
                end
                BYTE3: begin
                    shift_reg <= {shift_reg[15:0], in}; // Shift left by 8 bits and input new byte
                    done <= 1'b0;
                end
                DONE: begin
                    out_bytes <= shift_reg;
                    done <= 1'b1;
                end
                default: begin
                    shift_reg <= 24'd0;
                    out_bytes <= 24'd0;
                    done <= 1'b0;
                end
            endcase
        end
    end

endmodule
