module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [7:0] data_reg;
    reg [3:0] bit_count;
    
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
               ERROR = 4'd11;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case(state)
            IDLE: 
                if (~in) next_state = START;
                else next_state = IDLE;
            START:
                if (~in) next_state = BIT0;
                else next_state = IDLE;
            BIT0: next_state = BIT1;
            BIT1: next_state = BIT2;
            BIT2: next_state = BIT3;
            BIT3: next_state = BIT4;
            BIT4: next_state = BIT5;
            BIT5: next_state = BIT6;
            BIT6: next_state = BIT7;
            BIT7: next_state = STOP;
            STOP:
                if (in) next_state = IDLE;
                else next_state = ERROR;
            ERROR:
                if (in) next_state = IDLE;
                else next_state = ERROR;
            default: next_state = IDLE;
        endcase
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 0;
            data_reg <= 0;
            out_byte <= 0;
            done <= 0;
        end
        else begin
            case(state)
                IDLE: begin
                    bit_count <= 0;
                    done <= 0;
                end
                START: begin
                    bit_count <= 0;
                end
                BIT0: begin
                    data_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end
                BIT1: begin
                    data_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end
                BIT2: begin
                    data_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end
                BIT3: begin
                    data_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end
                BIT4: begin
                    data_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end
                BIT5: begin
                    data_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end
                BIT6: begin
                    data_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end
                BIT7: begin
                    data_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end
                STOP: begin
                    if (in) begin
                        out_byte <= data_reg;
                        done <= 1;
                    end
                    else
                        done <= 0;
                end
                ERROR: begin
                    done <= 0;
                end
            endcase
        end
    end

endmodule
