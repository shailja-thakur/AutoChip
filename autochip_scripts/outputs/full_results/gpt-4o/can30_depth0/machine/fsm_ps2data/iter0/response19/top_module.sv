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
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            BYTE1: next_state = in[2] ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // Output and shift register update logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end
        else begin
            case (state)
                BYTE1: if (in[2]) shift_reg <= {shift_reg[15:0], in};
                BYTE2: shift_reg <= {shift_reg[15:0], in};
                BYTE3: shift_reg <= {shift_reg[15:0], in};
                DONE: begin
                    out_bytes <= shift_reg;
                    done <= 1'b1;
                end
            endcase
        end
    end

    // Reset done signal
    always @(posedge clk or posedge reset) begin
        if (reset)
            done <= 1'b0;
        else if (state != DONE)
            done <= 1'b0;
    end
    
endmodule
