module top_module (
    input clk,
    input in,
    input reset,
    output done
);
    reg [3:0] state;
    reg [3:0] next_state;
    
    localparam IDLE = 4'd0,       // Idle state
               START = 4'd1,      // Waiting for start bit
               DATA_0 = 4'd2,     // Receiving data bit 0
               DATA_1 = 4'd3,     // Receiving data bit 1
               DATA_2 = 4'd4,     // Receiving data bit 2
               DATA_3 = 4'd5,     // Receiving data bit 3
               DATA_4 = 4'd6,     // Receiving data bit 4
               DATA_5 = 4'd7,     // Receiving data bit 5
               DATA_6 = 4'd8,     // Receiving data bit 6
               DATA_7 = 4'd9,     // Receiving data bit 7
               STOP = 4'd10;      // Waiting for stop bit

    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= IDLE;
        else
            state <= next_state;
    end
    
    always @(*) begin
        next_state = state;
        case(state)
            IDLE: if (in == 1'b0) next_state = START;       // Detect start bit (0)
            START: next_state = DATA_0;
            DATA_0: next_state = DATA_1;
            DATA_1: next_state = DATA_2;
            DATA_2: next_state = DATA_3;
            DATA_3: next_state = DATA_4;
            DATA_4: next_state = DATA_5;
            DATA_5: next_state = DATA_6;
            DATA_6: next_state = DATA_7;
            DATA_7: next_state = STOP;
            STOP: if (in == 1'b1) next_state = IDLE;   // Detect stop bit (1)
                  else next_state = STOP;              // Wait for stop bit if not seen
            default: next_state = IDLE;
        endcase
    end 

    assign done = (state == STOP && in == 1'b1); // done is high when stop bit is detected

endmodule
