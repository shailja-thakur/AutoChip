module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] shift_reg;

    // State encoding
    localparam BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            BYTE1: next_state = (in[2] == 1'b1) ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE: next_state = (in[2] == 1'b0) ? BYTE1 : DONE;
            default: next_state = BYTE1;
        endcase
    end

    // Output logic and shift register update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 24'h000000;
            out_bytes <= 24'h000000;
            done <= 1'b0;
        end else begin
            case (state)
                BYTE1: begin
                    if (in[2] == 1'b1) begin
                        shift_reg[23:16] <= in;
                        shift_reg[15:0] <= shift_reg[23:8];
                    end
                    done <= 1'b0;
                end
                BYTE2: begin
                    shift_reg[15:8] <= in;
                    shift_reg[7:0] <= shift_reg[23:16];
                    done <= 1'b0;
                end
                BYTE3: begin
                    shift_reg[7:0] <= in;
                    done <= 1'b0;
                end
                DONE: begin
                    out_bytes <= shift_reg;
                    done <= 1'b1;
                end
                default: begin
                    shift_reg <= shift_reg;
                    out_bytes <= out_bytes;
                    done <= done;
                end
            endcase
        end
    end

endmodule
