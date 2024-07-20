module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Define the states
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    // State register
    reg [1:0] state, next_state;

    // 24-bit register to accumulate the bytes
    reg [23:0] shift_reg;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and shift register update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            case (state)
                BYTE1: begin
                    if (in[2] == 1'b1) begin
                        next_state <= BYTE2;
                    end else begin
                        next_state <= BYTE1;
                    end
                    shift_reg <= {shift_reg[15:0], in};
                end
                BYTE2: begin
                    next_state <= BYTE3;
                    shift_reg <= {shift_reg[15:0], in};
                end
                BYTE3: begin
                    next_state <= DONE;
                    shift_reg <= {shift_reg[15:0], in};
                end
                DONE: begin
                    next_state <= BYTE1;
                    done <= 1'b1;
                    out_bytes <= shift_reg;
                end
                default: begin
                    next_state <= BYTE1;
                end
            endcase
        end
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 1'b0;
        end else if (state == DONE) begin
            done <= 1'b1;
            out_bytes <= shift_reg;
        end else begin
            done <= 1'b0;
        end
    end

endmodule
