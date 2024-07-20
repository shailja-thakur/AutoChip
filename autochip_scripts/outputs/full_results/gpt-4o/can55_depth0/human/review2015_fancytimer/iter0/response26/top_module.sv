module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State declaration
    typedef enum logic [2:0] {
        IDLE,
        DETECT1,
        DETECT11,
        DETECT110,
        DETECT1101,
        LOAD,
        COUNT,
        WAIT_ACK
    } state_t;
    
    state_t state, next_state;
    
    reg [3:0] delay, delay_counter;
    reg [9:0] cycle_counter;
    reg [3:0] shift_reg;
    reg [2:0] bit_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            delay <= 4'b0000;
            delay_counter <= 4'b0000;
            cycle_counter <= 10'b0000000000;
            shift_reg <= 4'b0000;
            bit_counter <= 3'b000;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    count <= 4'bxxxx;  // Don't-care value
                    done <= 1'b0;
                    counting <= 1'b0;
                    if (data) begin
                        next_state <= DETECT1;
                    end
                end
                
                DETECT1: begin
                    if (data) begin
                        next_state <= DETECT11;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                
                DETECT11: begin
                    if (!data) begin
                        next_state <= DETECT110;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                
                DETECT110: begin
                    if (data) begin
                        next_state <= DETECT1101;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                
                DETECT1101: begin
                    if(data) begin
                        next_state <= LOAD;
                        bit_counter <= 3'b100; // Next 4 bits
                    end
                    else begin
                        next_state <= IDLE;
                    end
                end
                
                LOAD: begin
                    shift_reg <= {shift_reg[2:0], data};
                    bit_counter <= bit_counter - 1;
                    if(bit_counter == 3'b000) begin
                        delay <= shift_reg;
                        delay_counter <= shift_reg;
                        counting <= 1'b1;
                        cycle_counter <= 10'd1000;
                        next_state <= COUNT;
                    end
                end

                COUNT: begin
                    if (cycle_counter == 10'd0) begin
                        if (delay_counter == 4'd0) begin
                            next_state <= WAIT_ACK;
                            counting <= 1'b0;
                            done <= 1'b1;
                        end else begin
                            delay_counter <= delay_counter - 4'd1;
                            cycle_counter <= 10'd1000;
                        end
                    end else begin
                        cycle_counter <= cycle_counter - 10'd1;
                    end
                end

                WAIT_ACK: begin
                    if (ack) begin
                        next_state <= IDLE;
                        done <= 1'b0;
                    end
                end

                default: next_state <= IDLE;
            endcase
        end
    end

    assign count = reset ? 4'bxxxx : delay_counter;

endmodule
