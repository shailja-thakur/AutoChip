module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] shift_reg;
    reg [2:0] bit_counter;
    reg [3:0] delay;
    reg [12:0] cycle_counter;

    // State encoding
    typedef enum reg [2:0] {
        SEARCH = 3'b000,
        LOAD_DURATION = 3'b001,
        COUNT = 3'b010,
        DONE = 3'b011,
        WAIT_ACK = 3'b100
    } state_t;
    
    state_t current_state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= SEARCH;
            shift_reg <= 4'b0000;
            bit_counter <= 3'b000;
            delay <= 4'b0000;
            cycle_counter <= 13'b0;
            counting <= 1'b0;
            done <= 1'b0;
            count <= 4'bxxxx;
        end
        else begin
            current_state <= next_state;
            
            case (current_state)
                SEARCH: begin
                    if (data == 1'b1) begin
                        shift_reg <= {shift_reg[2:0], data};
                        bit_counter <= bit_counter + 1;
                    end
                    else begin
                        shift_reg <= {shift_reg[2:0], data};
                    end
                    
                    if (shift_reg == 4'b1101 && bit_counter == 3) begin
                        next_state <= LOAD_DURATION;
                        bit_counter <= 0;
                    end
                    else begin
                        next_state <= SEARCH;
                    end
                end
                
                LOAD_DURATION: begin
                    shift_reg <= {shift_reg[2:0], data};
                    if (bit_counter < 3) begin
                        bit_counter <= bit_counter + 1;
                    end
                    else begin
                        delay <= {shift_reg[2:0], data};
                        next_state <= COUNT;
                        bit_counter <= 0;
                        cycle_counter <= 1000 * (delay + 1);
                        count <= delay;
                    end
                end

                COUNT: begin
                    counting <= 1'b1;
                    if (cycle_counter > 0) begin
                        cycle_counter <= cycle_counter - 1;
                    end
                    if (cycle_counter[9:0] == 0) begin
                        count <= count - 1;
                    end
                    if (cycle_counter == 0) begin
                        next_state <= DONE;
                        counting <= 1'b0;
                    end
                end

                DONE: begin
                    done <= 1'b1;
                    if (ack) begin
                        next_state <= WAIT_ACK;
                    end
                end

                WAIT_ACK: begin
                    done <= 1'b0;
                    if (!ack) begin
                        next_state <= SEARCH;
                    end
                end

                default: next_state <= SEARCH;
            endcase
        end
    end
endmodule
