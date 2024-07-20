module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State definitions
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] reg_bytes;

    // State transition logic
    always @(*) begin
        case (state)
            BYTE1: if (in[2] == 1) next_state = BYTE2; else next_state = BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  if (in[2] == 0) next_state = BYTE1; else next_state = DONE;
            default: next_state = BYTE1;
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            reg_bytes <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            case (next_state)
                BYTE1: begin
                    reg_bytes <= in;
                    done <= 1'b0;
                end
                BYTE2: begin
                    reg_bytes <= (reg_bytes << 8) | in;
                    done <= 1'b0;
                end
                BYTE3: begin
                    reg_bytes <= (reg_bytes << 8) | in;
                    done <= 1'b0;
                end
                DONE: begin
                    out_bytes <= (reg_bytes << 8) | in;
                    done <= 1'b1;
                end
            endcase
        end
    end

endmodule
