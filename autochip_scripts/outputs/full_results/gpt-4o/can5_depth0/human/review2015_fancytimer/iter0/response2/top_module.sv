module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE        = 3'b000, // Waiting for the start sequence 1101
        SHIFT_IN    = 3'b001, // Shifting in the delay value
        COUNT_DOWN  = 3'b010, // Counting down based on delay value
        WAIT_ACK    = 3'b011  // Waiting for user acknowledgement
    } state_t;
    
    state_t state, next_state;
    reg [3:0] delay;
    reg [12:0] counter; // 13 bits to count up to 8191 (5000 cycles max)

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 4'd0;
            counter <= 13'd0;
            delay <= 4'd0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == COUNT_DOWN && counter == 13'd0) begin
                count <= count - 1;
                counter <= 13'd1000;
            end else if (state == COUNT_DOWN) begin
                counter <= counter - 1;
            end
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                counting = 1'b0;
                done = 1'b0;
                if ({shift_reg[2:0], data} == 4'b1101) next_state = SHIFT_IN;
            end
            
            SHIFT_IN: begin
                counting = 1'b0;
                done = 1'b0;
                if (shift_count == 3'd3) begin
                    delay = {shift_reg[2:0], data};
                    next_state = COUNT_DOWN;
                    count = {shift_reg[2:0], data};
                    counter = 13'd1000;
                end
            end
            
            COUNT_DOWN: begin
                counting = 1'b1;
                done = 1'b0;
                if (count == 4'd0 && counter == 13'd0) next_state = WAIT_ACK;
            end
            
            WAIT_ACK: begin
                counting = 1'b0;
                done = 1'b1;
                if (ack == 1'b1) next_state = IDLE;
            end
        endcase
    end

    reg [3:0] shift_reg;
    reg [2:0] shift_count;
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 4'd0;
            shift_count <= 3'd0;
        end else if (state == IDLE) begin
            shift_reg <= {shift_reg[2:0], data};
        end else if (state == SHIFT_IN) begin
            shift_reg <= {shift_reg[2:0], data};
            shift_count <= shift_count + 1;
        end else begin
            shift_reg <= 4'd0;
            shift_count <= 3'd0;
        end
    end

    // Default values (can be ignored)
    initial begin
        state = IDLE;
        count = 4'd0;
        counter = 13'd0;
        delay = 4'd0;
        counting = 1'b0;
        done = 1'b0;
        shift_reg = 4'd0;
        shift_count = 3'd0;
    end

endmodule
