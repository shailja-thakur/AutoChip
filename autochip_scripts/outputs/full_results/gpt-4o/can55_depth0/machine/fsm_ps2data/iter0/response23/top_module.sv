module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    reg [2:0] state, next_state;
    reg [23:0] shift_reg;

    // State Encoding
    localparam BYTE1 = 3'b000,
               BYTE2 = 3'b001,
               BYTE3 = 3'b010,
               DONE  = 3'b011;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case(state)
            BYTE1: if (in[2] == 1'b1) next_state = BYTE2;
                   else next_state = BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE: next_state = BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // Output Logic and Shift Register Update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            case(state)
                BYTE1: begin
                    shift_reg <= {shift_reg[15:0], in};
                    done <= 1'b0;
                end
                BYTE2: begin
                    shift_reg <= {shift_reg[15:0], in};
                    done <= 1'b0;
                end
                BYTE3: begin
                    shift_reg <= {shift_reg[15:0], in};
                    done <= 1'b0;
                end
                DONE: begin
                    out_bytes <= shift_reg;
                    done <= 1'b1;
                end
                default: begin
                    shift_reg <= 24'b0;
                    out_bytes <= 24'b0;
                    done <= 1'b0;
                end
            endcase
        end
    end

endmodule
