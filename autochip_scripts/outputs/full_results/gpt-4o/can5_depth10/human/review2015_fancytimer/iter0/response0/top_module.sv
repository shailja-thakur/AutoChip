module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);
    reg [2:0] state, next_state;
    reg [3:0] delay, delay_reg, delay_countdown;
    reg [11:0] cycle_counter;  // 12 bits to count up to 1000 cycles

    // State definitions
    localparam RESET       = 3'd0;
    localparam SEARCH      = 3'd1;
    localparam SHIFT       = 3'd2;
    localparam COUNT       = 3'd3;
    localparam WAIT_ACK    = 3'd4;

    always @(posedge clk) begin
        if (reset)
            state <= RESET;
        else
            state <= next_state;
    end

    always @(posedge clk) begin
        if (reset) begin
            delay <= 4'd0;
            delay_reg <= 4'd0;
            delay_countdown <= 4'd0;
            cycle_counter <= 12'd1000;  // Default to 1000 cycles initially
            count <= 4'bxxxx;  // Don't care when not counting
        end else begin
            case (state)
                RESET: begin
                    count <= 4'bxxxx;  // Don't care when not counting
                    counting <= 1'b0;
                    done <= 1'b0;
                    delay <= 4'd0;
                    delay_reg <= 4'd0;
                    delay_countdown <= 4'd0;
                    cycle_counter <= 12'd1000;  // Default to 1000 cycles initially
                end
                SEARCH: begin
                    if ({data, delay[3:1]} == 4'b1101) begin
                        delay <= 4'b0001;  // Initialize shift pattern state
                    end else begin
                        delay <= {delay[2:0], data};  // Shift in data
                    end
                end
                SHIFT: begin
                    delay_reg <= {delay_reg[2:0], data};  // Shift in next 4 bits MSB first
                end
                COUNT: begin
                    if (cycle_counter == 12'd0) begin
                        cycle_counter <= 12'd1000;
                        count <= delay_countdown;
                        delay_countdown <= delay_countdown - 1;
                    end else
                        cycle_counter <= cycle_counter - 1;
                end
                WAIT_ACK: begin
                    done <= 1'b1;
                end
            endcase
        end
    end

    always @(*) begin
        next_state = state; // Default to hold state
        case (state)
            RESET: begin
                next_state = SEARCH;
            end
            SEARCH: begin
                if (delay[3:0] == 4'b1101) begin
                    next_state = SHIFT;
                end
            end
            SHIFT: begin
                if (delay_reg == 4'b0000) begin
                    next_state = COUNT;  // Start counting when all bits are shifted
                end
            end
            COUNT: begin
                counting <= 1'b1;
                if (delay_countdown == 4'd0) begin
                    next_state = WAIT_ACK;  // Wait for user acknowledgement
                end
            end
            WAIT_ACK: begin
                counting <= 1'b0;
                if (ack) begin
                    done <= 1'b0;
                    next_state = RESET;  // Reset after acknowledgement
                end
            end
        endcase
    end
endmodule
