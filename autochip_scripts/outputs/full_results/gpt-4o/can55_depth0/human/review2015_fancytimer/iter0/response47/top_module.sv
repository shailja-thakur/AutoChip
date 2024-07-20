module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack 
);
    // State definitions
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        PATTERN_DETECTED = 3'b001,
        READ_DELAY = 3'b010,
        COUNTING = 3'b011,
        DONE = 3'b100
    } state_t;
    
    // Register and wire declarations
    reg [3:0] delay;
    reg [2:0] state, next_state;
    reg [12:0] count_cycles;
    
    // Sequential logic for state transition and delay/count cycles
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            delay <= 4'd0;
            count <= 4'd0;
            count_cycles <= 13'd0;
            done <= 1'b0;
            counting <= 1'b0;
        end 
        else begin
            state <= next_state;
            if (state == COUNTING)
                count_cycles <= count_cycles - 1;
            else if (state == READ_DELAY)
                delay <= {delay[2:0], data};
        end
    end
    
    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data == 1'b1) next_state = PATTERN_DETECTED;
            end
            PATTERN_DETECTED: begin
                if (data == 1'b1) next_state = READ_DELAY;
            end
            READ_DELAY: begin
                if (delay[3:0] != 4'b1111) next_state = COUNTING;
            end
            COUNTING: begin
                if (count_cycles == 0) next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack == 1'b1) next_state = IDLE;
            end
        endcase
    end
    
    // Output logic
    always @(posedge clk) begin
        case (state)
            IDLE: begin
                counting <= 1'b0;
                done <= 1'b0;
                count <= 4'hF;  // Indeterminate value as don't-care
            end
            PATTERN_DETECTED: begin
                delay <= {delay[2:0], data};
            end
            READ_DELAY: begin
                if (delay[3:0] != 4'b1111)
                    count_cycles <= (delay + 1) * 1000;
            end
            COUNTING: begin
                counting <= 1'b1;
                if (count_cycles % 1000 == 0) 
                    count <= delay - (count_cycles / 1000);
            end
            DONE: begin
                counting <= 1'b0;
                done <= 1'b1;
            end
        endcase
    end
endmodule
