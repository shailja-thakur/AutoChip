module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Define state encoding
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;
    
    // State register
    state_t state, next_state;
    
    // Register to hold the 24-bit output
    reg [23:0] shift_reg;

    // Sequential logic: state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end
    
    // Combinational logic: next state logic
    always @(*) begin
        case (state)
            BYTE1: if (in[2]) next_state = BYTE2; else next_state = BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = BYTE1;
            default: next_state = BYTE1;
        endcase
    end
    
    // Sequential logic: shift register update and output assignments
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            case (state)
                BYTE1: shift_reg <= {shift_reg[15:0], in};
                BYTE2: shift_reg <= {shift_reg[15:0], in};
                BYTE3: shift_reg <= {shift_reg[15:0], in};
                DONE: begin
                    out_bytes <= shift_reg;
                    done <= 1'b1;
                end
            endcase

            if (state != DONE)
                done <= 1'b0;
        end
    end
    
endmodule
