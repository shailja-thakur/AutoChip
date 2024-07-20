module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // Define states
    typedef enum logic [3:0] {
        S_IDLE,
        S_SEARCH,
        S_SHIFT,
        S_COUNT
    } state_t;
    
    // Define signals and registers
    reg [3:0] delay;
    reg [3:0] count_reg;
    reg [3:0] remaining_time;
    reg [3:0] shift_reg;
    wire [3:0] shifted_data;
    reg [3:0] next_state;
    reg [3:0] current_state;
    
    // Default values
    assign shifted_data = {1'b0, data[3:1]};
    
    // State machine
    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            delay <= 0;
            count_reg <= 0;
            remaining_time <= 0;
            shift_reg <= 0;
            current_state <= S_IDLE;
        end
        else begin
            current_state <= next_state;
            
            case (current_state)
                S_IDLE: begin
                    counting <= 0;
                    done <= 0;
                    if (data == 4'b1101) begin
                        next_state <= S_SHIFT;
                    end
                    else begin
                        next_state <= S_IDLE;
                    end
                end
                S_SEARCH: begin
                    counting <= 0;
                    done <= 0;
                    if (data == 4'b1101) begin
                        next_state <= S_SHIFT;
                    end
                    else begin
                        next_state <= S_SEARCH;
                    end
                end
                S_SHIFT: begin
                    counting <= 0;
                    done <= 0;
                    delay <= shifted_data;
                    count_reg <= shifted_data;
                    remaining_time <= shifted_data;
                    next_state <= S_COUNT;
                end
                S_COUNT: begin
                    counting <= 1;
                    done <= 0;
                    if (count_reg == 0) begin
                        next_state <= S_IDLE;
                    end
                    else begin
                        next_state <= S_COUNT;
                    end
                    count_reg <= count_reg - 1;
                end
            endcase
        end
    end

    // Output count
    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
        end
        else begin
            count <= counting ? remaining_time : 4'b0;
            remaining_time <= counting ? remaining_time - 1 : 4'b0;
        end
    end

endmodule
