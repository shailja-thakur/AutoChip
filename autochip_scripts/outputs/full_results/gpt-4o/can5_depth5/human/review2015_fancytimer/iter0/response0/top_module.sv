module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        DETECT = 3'b001,
        SHIFT = 3'b010,
        COUNT = 3'b011,
        WAIT_ACK = 3'b100
    } state_t;

    state_t state, next_state;

    logic [3:0] delay;
    logic [12:0] counter;
    logic [2:0] bit_count;
    logic [3:0] temp_delay;

    // State transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always_comb begin
        next_state = state;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (~reset)
                    next_state = DETECT;
            end

            DETECT: begin
                if (data == 1'b1) begin
                    temp_delay[3] = 1'b1;
                    next_state = SHIFT;
                end
            end

            SHIFT: begin
                if (bit_count == 3'd4) begin
                    next_state = COUNT;
                end
            end

            COUNT: begin
                counting = 1'b1;
                if (counter == 13'd1) begin
                    next_state = WAIT_ACK;
                end
            end

            WAIT_ACK: begin
                done = 1'b1;
                if (ack == 1'b1) begin
                    next_state = IDLE;
                end
            end

            default: next_state = IDLE;
        endcase
    end

    // Shift Register and Counter Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            delay <= 4'd0;
            bit_count <= 3'd0;
            counter <= 13'd1000;
        end else case (state)
            IDLE: begin
                bit_count <= 3'd0;
                counter <= 13'd1000;
            end

            SHIFT: begin
                if (bit_count < 3'd4) begin
                    delay <= {delay[2:0], data};
                    bit_count <= bit_count + 3'd1;
                end
            end

            COUNT: begin
                if (counter > 13'd1) begin
                    counter <= counter - 13'd1;
                    if (counter == 13'd1) begin
                        if (delay > 4'd0) begin
                            delay <= delay - 4'd1;
                            counter <= 13'd1000;
                        end else
                            counter <= 13'd0;
                    end
                end
            end

            default: ;
        endcase
    end

    // Output count logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            count <= 4'd0;
        else if (state == COUNT)
            count <= delay;
    end

endmodule
