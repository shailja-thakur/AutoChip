module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    reg [1:0] state, next_state;
    reg [23:0] byte_shift_reg;

    // State encoding
    localparam IDLE    = 2'b00, 
               BYTE1   = 2'b01, 
               BYTE2   = 2'b10, 
               DONE    = 2'b11;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // State transition logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = DONE;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic and byte shifting
    always @(posedge clk) begin
        if (reset) begin
            byte_shift_reg <= 24'b0;
            done <= 1'b0;
            out_bytes <= 24'b0;
        end else begin
            case (state)
                IDLE: begin
                    byte_shift_reg <= 24'b0;
                    done <= 1'b0;
                end
                BYTE1: begin
                    byte_shift_reg[23:16] <= in;
                end
                BYTE2: begin
                    byte_shift_reg[15:8] <= in;
                end
                DONE: begin
                    byte_shift_reg[7:0] <= in;
                    out_bytes <= byte_shift_reg;
                    done <= 1'b1;
                end
                default: begin
                    done <= 1'b0;
                end
            endcase
        end
    end
endmodule
