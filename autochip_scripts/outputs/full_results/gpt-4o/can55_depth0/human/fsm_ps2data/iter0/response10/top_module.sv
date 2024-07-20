module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum logic [1:0] {
        IDLE,
        BYTE1,
        BYTE2,
        BYTE3
    } state_t;
  
    state_t state, next_state;
    reg [23:0] shift_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
  
    // Next state logic
    always_comb begin
        case (state)
            IDLE: 
                if (in[3]) 
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

    // Output and register update logic
    always_ff @(posedge clk) begin
        if (reset) begin
            shift_reg <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            done <= 1'b0;
            case (state)
                IDLE: 
                    shift_reg <= 24'b0;
                BYTE1: 
                    shift_reg <= {shift_reg[15:0], in};
                BYTE2: 
                    shift_reg <= {shift_reg[15:0], in};
                BYTE3: begin
                    shift_reg <= {shift_reg[15:0], in};
                    out_bytes <= {shift_reg[15:0], in};
                    done <= 1'b1;
                end
            endcase
        end
    end
endmodule
