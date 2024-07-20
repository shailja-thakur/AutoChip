module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [7:0] shift_reg;
    reg [2:0] bit_count;

    localparam IDLE = 4'd0,
               START = 4'd1,
               BIT0 = 4'd2,
               BIT1 = 4'd3,
               BIT2 = 4'd4,
               BIT3 = 4'd5,
               BIT4 = 4'd6,
               BIT5 = 4'd7,
               BIT6 = 4'd8,
               BIT7 = 4'd9,
               STOP = 4'd10,
               DONE = 4'd11;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 8'd0;
            done <= 0;
            shift_reg <= 8'd0;
            bit_count <= 3'd0;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        case (state)
            IDLE: if (in == 0) next_state = START;
                  else next_state = IDLE;
            START: next_state = BIT0;
            BIT0: next_state = BIT1;
            BIT1: next_state = BIT2;
            BIT2: next_state = BIT3;
            BIT3: next_state = BIT4;
            BIT4: next_state = BIT5;
            BIT5: next_state = BIT6;
            BIT6: next_state = BIT7;
            BIT7: next_state = STOP;
            STOP: if (in == 1) next_state = DONE;
                      else next_state = IDLE;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            shift_reg <= 8'd0;
            done <= 0;
            bit_count <= 3'd0;
        end else begin
            done <= 0;
            case (state)
                START: bit_count <= 3'd0;
                BIT0: begin
                    shift_reg[0] <= in;
                    bit_count <= bit_count + 3'd1;
                end
                BIT1: begin
                    shift_reg[1] <= in;
                    bit_count <= bit_count + 3'd1;
                end
                BIT2: begin
                    shift_reg[2] <= in;
                    bit_count <= bit_count + 3'd1;
                end
                BIT3: begin
                    shift_reg[3] <= in;
                    bit_count <= bit_count + 3'd1;
                end
                BIT4: begin
                    shift_reg[4] <= in;
                    bit_count <= bit_count + 3'd1;
                end
                BIT5: begin
                    shift_reg[5] <= in;
                    bit_count <= bit_count + 3'd1;
                end
                BIT6: begin
                    shift_reg[6] <= in;
                    bit_count <= bit_count + 3'd1;
                end
                BIT7: begin
                    shift_reg[7] <= in;
                    bit_count <= bit_count + 3'd1;
                end
                STOP: begin
                    if (in == 1) begin
                        out_byte <= shift_reg;
                        done <= 1;
                    end
                end
                DONE: begin
                    shift_reg <= 8'd0;
                    bit_count <= 3'd0;
                end
                default: begin
                    shift_reg <= shift_reg;
                    bit_count <= bit_count;
                    done <= 0;
                end
            endcase
        end
    end
endmodule
