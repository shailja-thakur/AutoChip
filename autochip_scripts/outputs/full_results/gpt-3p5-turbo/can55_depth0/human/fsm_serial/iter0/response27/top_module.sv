module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    reg [3:0] state;
    reg [7:0] data_reg;
    reg start_bit, stop_bit;
    wire valid_data;

    // Counter for counting the incoming data bits
    reg [2:0] bit_counter;
    wire [2:0] next_bit_counter;

    // Flip flops for synchronizing signals
    reg in_sync, start_bit_sync, stop_bit_sync;

    // Next state logic
    always @(posedge clk, posedge reset)
    begin
        if (reset)
            state <= 0;
        else
        begin
            case (state)
                0:  if (start_bit && !in_sync)
                        state <= 1;
                    else
                        state <= 0;
                1:  if (bit_counter == 2'd7)
                        state <= 2;
                    else if (!in_sync)
                        state <= 0;
                    else
                        state <= 1;
                2:  if (stop_bit && !in_sync)
                        state <= 3;
                    else if (!in_sync)
                        state <= 0;
                    else
                        state <= 2;
                3:  state <= 0;
            endcase
        end
    end

    // Output logic
    always @(state)
    begin
        case (state)
            0:  done <= 0;
            3:  done <= 1;
            default: done <= done;
        endcase
    end

    // Next bit counter logic
    always @(posedge clk, posedge reset)
    begin
        if (reset)
            bit_counter <= 0;
        else
            bit_counter <= next_bit_counter;
    end

    // Synchronization flip flop logic
    always @(posedge clk)
    begin
        if (reset)
        begin
            in_sync <= 0;
            start_bit_sync <= 0;
            stop_bit_sync <= 0;
        end
        else
        begin
            in_sync <= in;
            start_bit_sync <= in_sync;
            stop_bit_sync <= in_sync;
        end
    end

    // Data register logic
    always @(posedge clk, posedge reset)
    begin
        if (reset)
            data_reg <= 8'b0;
        else if (state == 0 && start_bit && !in_sync)
            data_reg <= in;
        else if (state == 1 && in_sync)
            data_reg <= {data_reg[6:0], in};
        else
            data_reg <= data_reg;
    end

    // Stop bit verification
    assign valid_data = (state == 2) ? stop_bit_sync : 1'b0;

    // Output your valid bits for byte verification
    always @(posedge clk)
    begin
        start_bit = start_bit_sync;
        stop_bit = stop_bit_sync;
    end

    // Calculate next bit counter
    assign next_bit_counter = (state == 1) ? bit_counter + 1'd1 : 3'd0;

endmodule
