module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum logic [3:0] {
        IDLE       = 4'b0000,
        START_BIT  = 4'b0001,
        DATA_BIT_0 = 4'b0010,
        DATA_BIT_1 = 4'b0011,
        DATA_BIT_2 = 4'b0100,
        DATA_BIT_3 = 4'b0101,
        DATA_BIT_4 = 4'b0110,
        DATA_BIT_5 = 4'b0111,
        DATA_BIT_6 = 4'b1000,
        DATA_BIT_7 = 4'b1001,
        STOP_BIT   = 4'b1010
    } state_t;

    state_t current_state, next_state;
    reg [7:0] data_reg;
    reg [2:0] bit_counter;

    // Sequential part: state transitions
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Combinational part: next state logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: if (in == 1'b0) next_state = START_BIT;
            START_BIT: next_state = DATA_BIT_0;
            DATA_BIT_0: next_state = DATA_BIT_1;
            DATA_BIT_1: next_state = DATA_BIT_2;
            DATA_BIT_2: next_state = DATA_BIT_3;
            DATA_BIT_3: next_state = DATA_BIT_4;
            DATA_BIT_4: next_state = DATA_BIT_5;
            DATA_BIT_5: next_state = DATA_BIT_6;
            DATA_BIT_6: next_state = DATA_BIT_7;
            DATA_BIT_7: next_state = STOP_BIT;
            STOP_BIT: if (in == 1'b1) next_state = IDLE;
                      else next_state = STOP_BIT;
        endcase
    end

    // Sequential part: data processing and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_reg <= 8'd0;
            bit_counter <= 3'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            case (current_state)
                IDLE: begin
                    done <= 1'b0;
                    bit_counter <= 3'd0;
                end
                START_BIT: done <= 1'b0;
                DATA_BIT_0: data_reg[0] <= in;
                DATA_BIT_1: data_reg[1] <= in;
                DATA_BIT_2: data_reg[2] <= in;
                DATA_BIT_3: data_reg[3] <= in;
                DATA_BIT_4: data_reg[4] <= in;
                DATA_BIT_5: data_reg[5] <= in;
                DATA_BIT_6: data_reg[6] <= in;
                DATA_BIT_7: data_reg[7] <= in;
                STOP_BIT: begin
                    if (in == 1'b1) begin
                        out_byte <= data_reg;
                        done <= 1'b1;
                    end else begin
                        done <= 1'b0;
                    end
                end
                default: begin
                    out_byte <= 8'd0;
                    done <= 1'b0;
                end
            endcase
        end
    end

endmodule
