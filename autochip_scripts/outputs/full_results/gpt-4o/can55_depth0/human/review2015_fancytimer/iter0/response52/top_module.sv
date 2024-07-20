module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] state, next_state;
    reg [3:0] pattern_shift_reg;
    reg [3:0] delay;
    reg [13:0] counter; // Large enough to count up to 16000
    
    // State encoding
    localparam IDLE = 4'b0000;
    localparam DETECT = 4'b0001;
    localparam LOAD_DELAY = 4'b0010;
    localparam COUNT = 4'b0011;
    localparam DONE = 4'b0100;

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // State machine next state and output logic
    always @(*) begin
        // Default values
        next_state = state;
        counting = 0;
        done = 0;
        count = 4'b1111; // Don't care state for non-counting period
        
        case(state)
            IDLE: begin
                if (pattern_shift_reg == 4'b1101) begin
                    next_state = LOAD_DELAY;
                end else begin
                    next_state = DETECT;
                end
            end
            DETECT: begin
                next_state = IDLE;
            end
            LOAD_DELAY: begin
                if (delay_valid) begin
                    next_state = COUNT;
                end
            end
            COUNT: begin
                counting = 1;
                count = (counter - 1) / 1000;
                if (counter == 14'd1) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end
    
    // Counter logic to count down from (delay + 1) * 1000
    always @(posedge clk) begin
        if (reset || next_state == LOAD_DELAY) begin
            counter <= (delay + 1) * 1000;
        end else if (counting && counter > 0) begin
            counter <= counter - 1;
        end
    end
    
    // Shift register to detect the 1101 pattern and load delay bits
    always @(posedge clk) begin
        if (reset || state == DONE) begin
            pattern_shift_reg <= 4'b0000;
        end else if (state == DETECT) begin
            pattern_shift_reg <= {pattern_shift_reg[2:0], data};
        end
    end
    
    // Shift register to load the delay value
    reg [2:0] delay_counter;
    reg delay_valid;
    
    always @(posedge clk) begin
        if (reset || state == COUNT) begin
            delay <= 4'b0000;
            delay_counter <= 3'b000;
            delay_valid <= 0;
        end else if (state == LOAD_DELAY) begin
            delay <= {delay[2:0], data};
            delay_counter <= delay_counter + 1;
            if (delay_counter == 3'b011) begin
                delay_valid <= 1;
            end
        end
    end

endmodule
