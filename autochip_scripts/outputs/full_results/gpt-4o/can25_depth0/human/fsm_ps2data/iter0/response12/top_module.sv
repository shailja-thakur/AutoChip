module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] shift_reg;
    
    localparam WAIT_HEADER = 2'b00,
               BYTE_1      = 2'b01,
               BYTE_2      = 2'b10,
               BYTE_3      = 2'b11;

    // State update
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_HEADER;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            WAIT_HEADER: begin
                if (in[3] == 1) begin
                    next_state = BYTE_1;
                end else begin
                    next_state = WAIT_HEADER;
                end
            end

            BYTE_1: next_state = BYTE_2;
            BYTE_2: next_state = BYTE_3;
            BYTE_3: next_state = WAIT_HEADER;

            default: next_state = WAIT_HEADER;
        endcase
    end

    // FSM output logic
    always @(posedge clk) begin
        if (reset) begin
            shift_reg <= 24'b0;
            done <= 0;
        end else begin
            case (state)
                WAIT_HEADER: begin
                    if (in[3] == 1) begin
                        shift_reg <= {in, 16'b0};
                        done <= 0;
                    end
                end
                BYTE_1: begin
                    shift_reg <= {shift_reg[23:16], in, 8'b0};
                end
                BYTE_2: begin
                    shift_reg <= {shift_reg[23:8], in};
                end
                BYTE_3: begin
                    out_bytes <= {shift_reg[23:8], in};
                    done <= 1;
                end
            endcase

            if (state != BYTE_3) begin
                done <= 0;
            end
        end
    end

endmodule
