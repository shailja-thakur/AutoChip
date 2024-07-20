module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    localparam IDLE = 2'b00,
               BYTE1 = 2'b01,
               BYTE2 = 2'b10,
               BYTE3 = 2'b11;

    reg [1:0] state, next_state;
    reg [23:0] data_reg;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            data_reg <= 24'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3]) next_state = BYTE1;
                else next_state = IDLE;
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            case (state)
                IDLE: done <= 0;
                BYTE1: data_reg[23:16] <= in;
                BYTE2: data_reg[15:8] <= in;
                BYTE3: begin
                    data_reg[7:0] <= in;
                    out_bytes <= data_reg;
                    done <= 1;
                end
                default: done <= 0;
            endcase
        end
    end

endmodule
