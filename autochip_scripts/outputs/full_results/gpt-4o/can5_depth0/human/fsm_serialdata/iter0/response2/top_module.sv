module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        BIT0 = 3'b010,
        BIT1 = 3'b011,
        BIT2 = 3'b100,
        BIT3 = 3'b101,
        BIT4 = 3'b110,
        BIT5 = 3'b111,
        BIT6 = 3'b000,
        BIT7 = 3'b001,
        STOP = 3'b010
    } state_t;

    reg [2:0] state, next_state;
    reg [7:0] data_byte;
    reg [2:0] bit_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data_byte <= 8'b0;
            bit_count <= 3'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    if (in == 1'b0)
                        next_state <= START;
                    else
                        next_state <= IDLE;
                end
                
                START: begin
                    if (in == 1'b0)
                        next_state <= BIT0;
                    else
                        next_state <= IDLE;
                end
                
                BIT0: begin
                    data_byte[0] <= in;
                    next_state <= BIT1;
                end
                
                BIT1: begin
                    data_byte[1] <= in;
                    next_state <= BIT2;
                end
                
                BIT2: begin
                    data_byte[2] <= in;
                    next_state <= BIT3;
                end
                
                BIT3: begin
                    data_byte[3] <= in;
                    next_state <= BIT4;
                end
                
                BIT4: begin
                    data_byte[4] <= in;
                    next_state <= BIT5;
                end
                
                BIT5: begin
                    data_byte[5] <= in;
                    next_state <= BIT6;
                end
                
                BIT6: begin
                    data_byte[6] <= in;
                    next_state <= BIT7;
                end
                
                BIT7: begin
                    data_byte[7] <= in;
                    next_state <= STOP;
                end
                
                STOP: begin
                    if (in == 1'b1) begin
                        out_byte <= data_byte;
                        done <= 1'b1;
                        next_state <= IDLE;
                    end else
                        next_state <= IDLE;
                end
            endcase
        end
    end
endmodule
