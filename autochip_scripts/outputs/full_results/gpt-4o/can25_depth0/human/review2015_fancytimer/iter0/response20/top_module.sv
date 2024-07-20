module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State declaration
    typedef enum logic [2:0] {
        IDLE,
        PATTERN_DETECT,
        SHIFT_DELAY,
        COUNT,
        DONE_WAIT
    } state_t;

    state_t state, next_state;

    reg [3:0] delay;
    reg [13:0] counter;
    reg [3:0] bit_count;
    reg [3:0] remaining_time;
	
    // Sequential state transition
    always @(posedge clk) begin
        if(reset) 
            state <= IDLE;
        else 
            state <= next_state;
    end

    // Sequential outputs and counter logic
    always @(posedge clk) begin
        if(reset) begin
            count <= 4'bxxxx;  // Don't care
            remaining_time <= 4'd0;
            counter <= 14'd0;
            delay <= 4'd0;
            bit_count <= 4'd0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case(state)
                IDLE: begin
                    count <= 4'bxxxx;  // Don't care
                    remaining_time <= 4'd0;
                    counter <= 14'd0;
                    delay <= 4'd0;
                    bit_count <= 4'd0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                PATTERN_DETECT: begin
                    // Bit shifting to detect pattern 1101
                    if (data) bit_count <= bit_count + 1;
                    else bit_count <= 0;
                end
                SHIFT_DELAY: begin
                    // Collect 4-bit delay value, MSB first
                    delay <= {delay[2:0], data};
                    bit_count <= bit_count + 1;
                end
                COUNT: begin
                    counting <= 1'b1;
                    if(counter == 14'd999) begin
                        counter <= 14'd0;
                        if(remaining_time > 4'd0) begin
                            remaining_time <= remaining_time - 1;
                        end else begin
                            counting <= 1'b0;
                            done <= 1'b1;
                        end
                    end else begin
                        counter <= counter + 1;
                    end 
                    count <= remaining_time;
                end
                DONE_WAIT: begin
                    done <= 1'b1;
                    counting <= 1'b0;
                    if (ack) begin
                        done <= 1'b0;
                    end
                end
            endcase
        end 
    end

    // Combinational next state logic
    always @(*) begin
        next_state = state;
        case(state)
            IDLE: next_state = PATTERN_DETECT;
		
            PATTERN_DETECT: begin
                if(data == 1'b1 && bit_count == 4) next_state = SHIFT_DELAY;
            end

            SHIFT_DELAY: begin
                if(bit_count == 4) begin
                    remaining_time = delay;
                    next_state = COUNT;
                end
            end
			
            COUNT: begin
                if(~counting && done) next_state = DONE_WAIT;
            end
			
            DONE_WAIT: begin
                if(ack) next_state = IDLE;
            end
        endcase
    end
endmodule
