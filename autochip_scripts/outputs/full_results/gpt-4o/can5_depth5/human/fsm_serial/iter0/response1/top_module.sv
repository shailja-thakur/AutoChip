module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

    reg [3:0] state, next_state;
    reg [2:0] bit_cnt;
    reg [7:0] data_byte;
    
    // State definitions
    localparam IDLE       = 4'b0000;
    localparam START_BIT  = 4'b0001;
    localparam DATA_BITS  = 4'b0010;
    localparam STOP_BIT   = 4'b0011;
    localparam WAIT_STOP  = 4'b0100;
    
    // State Transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_cnt <= 0;
            data_byte <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    // Next State Logic and Output Logic
    always @(*) begin
        done = 1'b0;
        case(state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            START_BIT: begin
                next_state = DATA_BITS;
                bit_cnt = 0;
            end
            DATA_BITS: begin
                if (bit_cnt == 3'b111)
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end
            STOP_BIT: begin
                if (in == 1'b1)
                    next_state = WAIT_STOP;
                else
                    next_state = IDLE;
            end
            WAIT_STOP: begin
                done = 1'b1;
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = WAIT_STOP;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
    
    // Data Register and Bit Counter Update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_cnt <= 0;
            data_byte <= 0;
        end else begin
            if (state == DATA_BITS) begin
                data_byte[bit_cnt] <= in;
                bit_cnt <= bit_cnt + 1;
            end else if (state == STOP_BIT) begin
                bit_cnt <= 0;
            end
        end
    end
    
endmodule
